resource "aws_s3_bucket" "flow_accept" {
  bucket = format("%s-accept", local.s3_bucket_name)
  acl    = "private"
  tags = merge(local.tags, { Name = format("%s-accept", local.s3_bucket_name) })
}

resource "aws_s3_bucket" "flow_reject" {
  bucket = format("%s-reject", local.s3_bucket_name)
  acl    = "private"
  tags = merge(local.tags, { Name = format("%s-reject", local.s3_bucket_name) })
}

resource "aws_s3_bucket" "athena_setting" {
  bucket = "fc-athena-setting"
  acl    = "private"
  tags = merge(local.tags, { Name = "fc-athena-setting" })
}

#CREATE EXTERNAL TABLE IF NOT EXISTS vpc_flow_logs (
#`version` int,
#`account_id` string,
#`interface_id` string,
#`srcaddr` string,
#`dstaddr` string,
#`srcport` int,
#`dstport` int,
#`protocol` bigint,
#`packets` bigint,
#`bytes` bigint,
#`start` bigint,
#`end` bigint,
#`action` string,
#`log_status` string
#)
#PARTITIONED BY (region string, day string)
#ROW FORMAT DELIMITED
#FIELDS TERMINATED BY ' '
#LOCATION 's3://fc-prod-flow-accept/AWSLogs/552661052297/vpcflowlogs/'
#TBLPROPERTIES
#(
#"skip.header.line.count"="1",
#"projection.enabled" = "true",
#"projection.region.type" = "enum",
#"projection.region.values" = "ap-northeast-2",
#"projection.day.type" = "date",
#"projection.day.range" = "2021/01/01,NOW",
#"projection.day.format" = "yyyy/MM/dd",
#"storage.location.template" = "s3://fc-prod-flow-accept/AWSLogs/552661052297/vpcflowlogs/${region}/${day}"
#)


#SELECT *
#FROM vpc_flow_logs
#WHERE day >= '2022/01/01' AND day < '2022/03/01'
#ORDER BY start DESC
#LIMIT 100


#SELECT interface_id,
#       srcaddr,
#       action,
#       protocol,
#       to_iso8601(from_unixtime(start)) AS start_time
#FROM test_table_vpclogs
#WHERE DAY >= '2022/01/01' AND DAY < '2022/03/01'


#SELECT SUM(packets) AS packetcount,
#       dstaddr
#FROM vpc_flow_logs
#WHERE dstport = 443
#  AND day >= '2022/01/01'
#  AND day < '2022/03/01'
#GROUP BY dstaddr
#ORDER BY packetcount DESC
#LIMIT 10