const AWS = require('aws-sdk')
const iam = new AWS.IAM()

const ONE_DAY = 24 * 60 * 60
const ONE_WEEK = 7 * ONE_DAY
const ONE_MONTH = 30 * ONE_DAY
const KEY_MAX_AGE = parseInt(process.env.KEY_MAX_AGE_SECS, 10) || 90 * ONE_DAY;
const KEY_MAX_INACTIVE_AGE = parseInt(process.env.KEY_MAX_INACTIVE_AGE, 10) || 30 * ONE_DAY;

const IS_DELETE_EXPIRED_KEY = process.env.IS_DELETE_EXPIRED_KEY || false
const IS_INACTIVE_USEUSED_KEY = process.env.IS_INACTIVE_USEUSED_KEY || false

const getUsers = async () => iam.listUsers().promise();

const getKeys = async (users) =>
    Promise.all(users.map(user => iam.listAccessKeys({ UserName: user.UserName }).promise()))

const getKeyLastUsed = async (keyId) =>
    iam.getAccessKeyLastUsed({ AccessKeyId: keyId }).promise()

const updateAccessKey = async (userName, keyId, status) =>
  iam.updateAccessKey({ UserName: userName, AccessKeyId: keyId, Status: status }).promise()

const deleteAccessKey = async (userName, keyId) =>
  iam.deleteAccessKey({ UserName: userName, AccessKeyId: keyId }).promise()


const ageSecs = (dateString) => {
    const createDate = new Date(dateString)
    const now = new Date()
    return (now.getTime() - createDate.getTime()) / 1000
}

const checkExpired = (dateString, maxAgeSecs) => ageSecs(dateString) >= maxAgeSecs

const handleAccessKeys = async ([user, accessKeys]) => {
    console.log(`\nChecking user ${user.UserName}`)
    if (!accessKeys.length) {
        console.log('No access keys found')
        return
    }

    const task = accessKeys.map(key => {
        // 키만료는 안됐지만 사용하지 않은 기간 만료
        if (!checkExpired(key.CreateDate, KEY_MAX_AGE)) {
            if (key.Status === "Active") {
                const LastUsed = key.LastUsed.AccessKeyLastUsed
                const lastUsedDate = LastUsed.LastUsedDate ? LastUsed.LastUsedDate : key.CreateDate

                if(IS_INACTIVE_USEUSED_KEY && checkExpired(lastUsedDate, KEY_MAX_INACTIVE_AGE)) {
                    console.log(`${key.AccessKeyId} 미사용 기간 만료`)
                    // slack noti
                    return updateAccessKey(key.UserName, key.AccessKeyId, "Inactive")
                }
            }
            return undefined;
        }

        // 키만료
        console.log(`${key.AccessKeyId} 키 만료`)
        if (IS_DELETE_EXPIRED_KEY) {
            // slack noti
            return deleteAccessKey(key.UserName, key.AccessKeyId)
        }
        return undefined;
    })

    return Promise.all(task.filter(x => x))
}

exports.handler = async (event, context) => {
    const userRtv = await getUsers()
    const users = userRtv.Users

    const keyRtv = await getKeys(users)
    const keys = keyRtv.map(x => x.AccessKeyMetadata)

    const keyLastUsedRtv = await Promise.all(keys.flatMap(x => x.map(each => getKeyLastUsed(each.AccessKeyId))))

    const usersAndKeys = users.map((user, idx) => [user, keys[idx]])
    keys.map((x, idx) => {
        const keyCount = x.length
        const arr = keyLastUsedRtv.splice(0, keyCount)
        usersAndKeys[idx][1].map((y, yIdx) => Object.assign(y,{ LastUsed: arr[yIdx]}))
    })

    const rtv = await Promise.all(usersAndKeys.map(handleAccessKeys))
}

(async() => {
   await this.handler()
})()