package com.microsoft.att;

public class Constants {
    public static final String FAKE_ALERT =  "{" +
    "'schemaId':'azureMonitorCommonAlertSchema'," +
    "'data':{" +
    "'essentials': {" +
    "'alertId':'/subscriptions/<subscription ID>/providers/Microsoft.AlertsManagement/alerts/b9569717-bc32-442f-add5-83a997729330'," +
    "'alertRule':'WCUS-R2-Gen2'," +
    "'severity': 'Sev3'," +
    "'signalType': 'Metric'," +
    "'monitorCondition': 'Resolved'," +
    "'monitoringService':'Platform'," +
    "'alertTargetIDs': ['/subscriptions/0fb21625-3946-4f04-8934-f62e93621e1a/resourcegroups/pipelinealertrg/providers/microsoft.compute/virtualmachines/wcus-r2-gen2']," +
    "'originAlertId':'3f2d4487-b0fc-4125-8bd5-7ad17384221e_PipeLineAlertRG_microsoft.insights_metricAlerts_WCUS-R2-Gen2_-117781227'," +
    "'firedDateTime':'2019-03-22T13:58:24.3713213Z'," +
    "'resolvedDateTime': '2019-03-22T14:03:16.2246313Z'," +
    "'description': ''," +
    "'essentialsVersion': '1.0','alertContextVersion': '1.0'" +
    "}," +
    "'alertContext':{" +
    "'properties': null," +
    "'conditionType':'SingleResourceMultipleMetricCriteria'," +
    "'condition': {" +
    "'windowSize': 'PT5M'," +
    "'allOf': [{" +
    "'metricName': 'Percentage CPU'," +
    "'metricNamespace':'Microsoft.Compute/virtualMachines'," +
    "'operator':'GreaterThan'," +
    "'threshold':'25'," +
    "'timeAggregation': 'Average'," +
    "'dimensions':[{" +
    "'name': 'ResourceId'," +
    "'value': '3efad9dc-3d50-4eac-9c87-8b3fd6f97e4e'}]," +
    "'metricValue': 7.727}]} }  }}";
}
