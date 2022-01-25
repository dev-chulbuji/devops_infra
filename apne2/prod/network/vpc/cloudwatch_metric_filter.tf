resource "aws_cloudwatch_log_metric_filter" "ssh" {
  log_group_name = aws_cloudwatch_log_group.reject.name
  pattern = "[version, accountid, interfaceid, srcaddr, dstaddr, srcport, dstport=\"22\", protocol, packets, bytes, start, end, action=\"REJECT\", logstatus]"
#  pattern = "[version, vpcid, subnetid, instanceid, interfaceid, accountid, type, srcaddr, dstaddr, srcport, dstport=\"22\", pktsrcaddr, pktdstaddr, protocol, bytes, packets, start, end, action=\"REJECT\", tcpflags, logstatus]"
  name = "RejectedSSHCount"

  metric_transformation {
    name = "RejectedSSHCount"
    namespace = "VPCFlowLogsMetrics"
    value = "1"
  }
}