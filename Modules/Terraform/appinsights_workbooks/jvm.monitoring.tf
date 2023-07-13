
resource "azurerm_template_deployment" "jvmwokrbook1" {
    for_each                = var.jvm_workbooks
    name                    = each.value["workbookName"]
    deployment_mode         = "Incremental"
    resource_group_name     = data.azurerm_resource_group.this.name

    parameters = {
        "workbookDisplayName"   = each.value["workbookDisplayName"]
        "workbookSourceId"      = each.value["workbookSourceId"]
    }

    template_body = <<DEPLOY
    {
    "contentVersion": "1.0.0.0",
    "parameters": {
      "workbookDisplayName": {
        "type": "string",
        "defaultValue": "<workbook_display_name>",
        "metadata": {
          "description": "The friendly name for the workbook that is used in the Gallery or Saved List.  This name must be unique within a resource group."
        }
      },
      "workbookType": {
        "type": "string",
        "defaultValue": "workbook",
        "metadata": {
          "description": "The gallery that the workbook will been shown under. Supported values include workbook, tsg, etc. Usually, this is 'workbook'"
        }
      },
      "workbookSourceId": {
        "type": "string",
        "defaultValue": "<workbook_source_id>",
        "metadata": {
          "description": "The id of resource instance to which the workbook will be associated"
        }
      },
      "workbookId": {
        "type": "string",
        "defaultValue": "[newGuid()]",
        "metadata": {
          "description": "The unique guid for this workbook instance"
        }
      }
    },
    "resources": [
      {
        "name": "[parameters('workbookId')]",
        "type": "microsoft.insights/workbooks",
        "location": "[resourceGroup().location]",
        "apiVersion": "2018-06-17-preview",
        "dependsOn": [],
        "kind": "shared",
        "properties": {
          "displayName": "[parameters('workbookDisplayName')]",
          "serializedData": "{\"version\":\"Notebook/1.0\",\"items\":[{\"type\":1,\"content\":{\"json\":\"## JVM Metrics workbook\\n---\\n\\nThis workbook focus on JVM related Metrics collected by Application Insights agent.\"},\"name\":\"text - 2\"},{\"type\":9,\"content\":{\"version\":\"KqlParameterItem/1.0\",\"crossComponentResources\":[\"/subscriptions/0ed04194-6098-4e07-af03-c51130e49b37/resourceGroups/monitor-rg/providers/microsoft.insights/components/petclinic-insights\"],\"parameters\":[{\"id\":\"e65eb0a0-949c-4d4f-bb8e-f5f74100744c\",\"version\":\"KqlParameterItem/1.0\",\"name\":\"TimeRange\",\"label\":\"Time Range\",\"type\":4,\"description\":\"Time Range\",\"value\":{\"durationMs\":300000},\"typeSettings\":{\"selectableValues\":[{\"durationMs\":300000},{\"durationMs\":900000},{\"durationMs\":1800000},{\"durationMs\":3600000},{\"durationMs\":14400000},{\"durationMs\":43200000},{\"durationMs\":86400000},{\"durationMs\":172800000},{\"durationMs\":259200000},{\"durationMs\":604800000}]}},{\"id\":\"8fcedc74-db82-4be8-8f32-4dd16382d2f6\",\"version\":\"KqlParameterItem/1.0\",\"name\":\"subscription\",\"label\":\"Subscription\",\"type\":6,\"isRequired\":true,\"value\":\"value::1\",\"typeSettings\":{\"additionalResourceOptions\":[\"value::1\"],\"includeAll\":false}},{\"id\":\"b2a6c78c-3435-4a98-b887-f0cabbccc823\",\"version\":\"KqlParameterItem/1.0\",\"name\":\"ApplicationInsightsResource\",\"label\":\"Application Insights\",\"type\":5,\"isRequired\":true,\"multiSelect\":true,\"quote\":\"'\",\"delimiter\":\",\",\"query\":\"where type =~ 'microsoft.insights/components'\\r\\n| project id\",\"crossComponentResources\":[\"{subscription}\"],\"value\":[\"value::all\"],\"typeSettings\":{\"resourceTypeFilter\":{\"microsoft.insights/components\":true},\"additionalResourceOptions\":[\"value::all\"]},\"queryType\":1,\"resourceType\":\"microsoft.resourcegraph/resources\"}],\"style\":\"pills\",\"queryType\":0,\"resourceType\":\"microsoft.resourcegraph/resources\"},\"name\":\"parameters - 11\"},{\"type\":10,\"content\":{\"chartId\":\"workbookf3de3643-eb8c-47b3-aa4a-e9cfb3b83265\",\"version\":\"MetricsItem/2.0\",\"size\":0,\"chartType\":2,\"metricScope\":0,\"resourceIds\":[\"{ApplicationInsightsResource}\"],\"timeContext\":{\"durationMs\":0},\"timeContextFromParameter\":\"TimeRange\",\"resourceType\":\"microsoft.insights/components\",\"resourceParameter\":\"ApplicationInsightsResource\",\"metrics\":[{\"namespace\":\"azure.applicationinsights\",\"metric\":\"azure.applicationinsights--Heap Memory Used (MB)\",\"aggregation\":4,\"splitBy\":null,\"columnName\":\"Avg Heap Memory Used (MB)\"}],\"title\":\"Avg Heap Memory Used (MB)\",\"gridFormatType\":1,\"tileSettings\":{\"showBorder\":false,\"titleContent\":{\"columnMatch\":\"Name\",\"formatter\":13},\"leftContent\":{\"columnMatch\":\"Value\",\"formatter\":12,\"formatOptions\":{\"palette\":\"auto\"},\"numberFormat\":{\"unit\":17,\"options\":{\"maximumSignificantDigits\":3,\"maximumFractionDigits\":2}}}},\"mapSettings\":{\"locInfo\":\"AzureResource\",\"sizeSettings\":\"Value\",\"sizeAggregation\":\"Sum\",\"legendMetric\":\"Value\",\"legendAggregation\":\"Sum\",\"itemColorSettings\":{\"type\":\"heatmap\",\"colorAggregation\":\"Sum\",\"nodeColorField\":\"Value\",\"heatmapPalette\":\"greenRed\"},\"locInfoColumn\":\"Name\"},\"graphSettings\":{\"type\":0,\"topContent\":{\"columnMatch\":\"Subscription\",\"formatter\":1},\"centerContent\":{\"columnMatch\":\"Value\",\"formatter\":1,\"numberFormat\":{\"unit\":17,\"options\":{\"maximumSignificantDigits\":3,\"maximumFractionDigits\":2}}}},\"gridSettings\":{\"formatters\":[{\"columnMatch\":\"Subscription\",\"formatter\":5},{\"columnMatch\":\"Name\",\"formatter\":13,\"formatOptions\":{\"linkTarget\":\"Resource\"}},{\"columnMatch\":\"Avg Heap Memory Used (MB) Timeline\",\"formatter\":5},{\"columnMatch\":\"azure.applicationinsights--Heap Memory Used (MB)\",\"formatter\":1,\"numberFormat\":{\"unit\":0,\"options\":null}}],\"rowLimit\":10000}},\"customWidth\":\"50\",\"name\":\"Avg Heap Memory Used (MB)\",\"styleSettings\":{\"maxWidth\":\"50%\"}},{\"type\":10,\"content\":{\"chartId\":\"workbookdebcedef-f8ec-41e3-bd61-8126769da8df\",\"version\":\"MetricsItem/2.0\",\"size\":0,\"chartType\":2,\"color\":\"redBright\",\"metricScope\":0,\"resourceIds\":[\"{ApplicationInsightsResource}\"],\"timeContext\":{\"durationMs\":0},\"timeContextFromParameter\":\"TimeRange\",\"resourceType\":\"microsoft.insights/components\",\"resourceParameter\":\"ApplicationInsightsResource\",\"metrics\":[{\"namespace\":\"microsoft.insights/components/kusto\",\"metric\":\"microsoft.insights/components/kusto-Custom-customMetrics/jvm_buffer_memory_used\",\"aggregation\":4,\"splitBy\":null}],\"title\":\"Avg JVM Buffer Memory Used \",\"gridFormatType\":1,\"tileSettings\":{\"showBorder\":false,\"titleContent\":{\"columnMatch\":\"Name\",\"formatter\":13},\"leftContent\":{\"columnMatch\":\"Value\",\"formatter\":12,\"formatOptions\":{\"palette\":\"auto\"},\"numberFormat\":{\"unit\":17,\"options\":{\"maximumSignificantDigits\":3,\"maximumFractionDigits\":2}}}},\"gridSettings\":{\"formatters\":[{\"columnMatch\":\"Subscription\",\"formatter\":5},{\"columnMatch\":\"Name\",\"formatter\":13,\"formatOptions\":{\"linkTarget\":\"Resource\"}},{\"columnMatch\":\"microsoft.insights/components/kusto-Custom-customMetrics/jvm_buffer_memory_used Timeline\",\"formatter\":5},{\"columnMatch\":\"microsoft.insights/components/kusto-Custom-customMetrics/jvm_buffer_memory_used\",\"formatter\":1,\"numberFormat\":{\"unit\":0,\"options\":null}}],\"rowLimit\":10000,\"labelSettings\":[{\"columnId\":\"microsoft.insights/components/kusto-Custom-customMetrics/jvm_buffer_memory_used\",\"label\":\"jvm_buffer_memory_used (Average)\"},{\"columnId\":\"microsoft.insights/components/kusto-Custom-customMetrics/jvm_buffer_memory_used Timeline\",\"label\":\"jvm_buffer_memory_used Timeline\"}]}},\"customWidth\":\"50\",\"name\":\"Avg jvm_buffer_memory_used \",\"styleSettings\":{\"maxWidth\":\"50%\"}},{\"type\":10,\"content\":{\"chartId\":\"workbook954133fe-ff99-4967-99ba-e413ed613f3f\",\"version\":\"MetricsItem/2.0\",\"size\":0,\"chartType\":3,\"color\":\"blue\",\"metricScope\":0,\"resourceIds\":[\"{ApplicationInsightsResource}\"],\"timeContext\":{\"durationMs\":0},\"timeContextFromParameter\":\"TimeRange\",\"resourceType\":\"microsoft.insights/components\",\"resourceParameter\":\"ApplicationInsightsResource\",\"metrics\":[{\"namespace\":\"microsoft.insights/components/kusto\",\"metric\":\"microsoft.insights/components/kusto-Custom-customMetrics/jvm_gc_memory_allocated\",\"aggregation\":4,\"splitBy\":null}],\"title\":\"Avg JVM GC Memory Allocated\",\"gridSettings\":{\"rowLimit\":10000}},\"customWidth\":\"50\",\"name\":\"metric - 3\",\"styleSettings\":{\"maxWidth\":\"50%\"}},{\"type\":10,\"content\":{\"chartId\":\"workbook5dd122fd-4323-43a8-8323-5dee358f4368\",\"version\":\"MetricsItem/2.0\",\"size\":0,\"chartType\":2,\"color\":\"redBright\",\"metricScope\":0,\"resourceIds\":[\"{ApplicationInsightsResource}\"],\"timeContext\":{\"durationMs\":0},\"timeContextFromParameter\":\"TimeRange\",\"resourceType\":\"microsoft.insights/components\",\"resourceParameter\":\"ApplicationInsightsResource\",\"metrics\":[{\"namespace\":\"microsoft.insights/components/kusto\",\"metric\":\"microsoft.insights/components/kusto-Custom-customMetrics/jvm_gc_memory_promoted\",\"aggregation\":4,\"splitBy\":null}],\"title\":\"Avg JVM GC Memory Promoted\",\"gridSettings\":{\"rowLimit\":10000}},\"customWidth\":\"50\",\"name\":\"Avg jvm_gc_memory_promoted\",\"styleSettings\":{\"maxWidth\":\"50%\"}},{\"type\":10,\"content\":{\"chartId\":\"workbook64f032e6-fca1-4b99-84da-32f91fc4b410\",\"version\":\"MetricsItem/2.0\",\"size\":0,\"chartType\":2,\"metricScope\":0,\"resourceIds\":[\"{ApplicationInsightsResource}\"],\"timeContext\":{\"durationMs\":0},\"timeContextFromParameter\":\"TimeRange\",\"resourceType\":\"microsoft.insights/components\",\"resourceParameter\":\"ApplicationInsightsResource\",\"metrics\":[{\"namespace\":\"microsoft.insights/components/kusto\",\"metric\":\"microsoft.insights/components/kusto-Custom-customMetrics/jvm_gc_pause\",\"aggregation\":4,\"splitBy\":null}],\"title\":\"Avg JVM GC Pause\",\"gridSettings\":{\"rowLimit\":10000}},\"customWidth\":\"50\",\"name\":\"Avg JVM GC Pause\",\"styleSettings\":{\"maxWidth\":\"50%\"}},{\"type\":10,\"content\":{\"chartId\":\"workbook4bf8601a-5a13-4e38-8275-1daddb06d50d\",\"version\":\"MetricsItem/2.0\",\"size\":0,\"chartType\":2,\"color\":\"redBright\",\"metricScope\":0,\"resourceIds\":[\"{ApplicationInsightsResource}\"],\"timeContext\":{\"durationMs\":0},\"timeContextFromParameter\":\"TimeRange\",\"resourceType\":\"microsoft.insights/components\",\"resourceParameter\":\"ApplicationInsightsResource\",\"metrics\":[{\"namespace\":\"azure.applicationinsights\",\"metric\":\"azure.applicationinsights--jvm_threads_live\",\"aggregation\":4,\"splitBy\":null}],\"title\":\"JVM threads live\",\"tileSettings\":{\"showBorder\":false,\"titleContent\":{\"columnMatch\":\"Name\",\"formatter\":13},\"leftContent\":{\"columnMatch\":\"Value\",\"formatter\":12,\"formatOptions\":{\"palette\":\"auto\"},\"numberFormat\":{\"unit\":17,\"options\":{\"maximumSignificantDigits\":3,\"maximumFractionDigits\":2}}}},\"gridSettings\":{\"formatters\":[{\"columnMatch\":\"Subscription\",\"formatter\":5},{\"columnMatch\":\"Name\",\"formatter\":13,\"formatOptions\":{\"linkTarget\":\"Resource\"}},{\"columnMatch\":\"azure.applicationinsights--jvm_threads_live Timeline\",\"formatter\":5},{\"columnMatch\":\"azure.applicationinsights--jvm_threads_live\",\"formatter\":1,\"numberFormat\":{\"unit\":0,\"options\":null}},{\"columnMatch\":\"Metric\",\"formatter\":1},{\"columnMatch\":\"Aggregation\",\"formatter\":5},{\"columnMatch\":\"Value\",\"formatter\":1},{\"columnMatch\":\"Timeline\",\"formatter\":9}],\"rowLimit\":10000}},\"customWidth\":\"50\",\"name\":\"JVM threads live\",\"styleSettings\":{\"maxWidth\":\"50%\"}},{\"type\":10,\"content\":{\"chartId\":\"workbookfa502a5e-7982-4dcb-8c1d-19090a3cdc6c\",\"version\":\"MetricsItem/2.0\",\"size\":0,\"chartType\":2,\"metricScope\":0,\"resourceIds\":[\"{ApplicationInsightsResource}\"],\"timeContext\":{\"durationMs\":0},\"timeContextFromParameter\":\"TimeRange\",\"resourceType\":\"microsoft.insights/components\",\"resourceParameter\":\"ApplicationInsightsResource\",\"metrics\":[{\"namespace\":\"azure.applicationinsights\",\"metric\":\"azure.applicationinsights--Thread Count\",\"aggregation\":4,\"splitBy\":null}],\"title\":\"Thread Count\",\"tileSettings\":{\"showBorder\":false,\"titleContent\":{\"columnMatch\":\"Name\",\"formatter\":13},\"leftContent\":{\"columnMatch\":\"Value\",\"formatter\":12,\"formatOptions\":{\"palette\":\"auto\"},\"numberFormat\":{\"unit\":17,\"options\":{\"maximumSignificantDigits\":3,\"maximumFractionDigits\":2}}}},\"mapSettings\":{\"locInfo\":\"AzureResource\",\"sizeSettings\":\"Value\",\"sizeAggregation\":\"Sum\",\"legendMetric\":\"Value\",\"legendAggregation\":\"Sum\",\"itemColorSettings\":{\"type\":\"heatmap\",\"colorAggregation\":\"Sum\",\"nodeColorField\":\"Value\",\"heatmapPalette\":\"greenRed\"},\"locInfoColumn\":\"Name\"},\"gridSettings\":{\"formatters\":[{\"columnMatch\":\"Subscription\",\"formatter\":5},{\"columnMatch\":\"Name\",\"formatter\":13,\"formatOptions\":{\"linkTarget\":\"Resource\"}},{\"columnMatch\":\"Metric\",\"formatter\":1},{\"columnMatch\":\"Aggregation\",\"formatter\":5},{\"columnMatch\":\"Value\",\"formatter\":1},{\"columnMatch\":\"Timeline\",\"formatter\":9}],\"rowLimit\":10000}},\"customWidth\":\"50\",\"name\":\"Thread Count\",\"styleSettings\":{\"maxWidth\":\"50%\"}},{\"type\":10,\"content\":{\"chartId\":\"workbookea5a4f2e-6b68-497c-b8ff-8f611f919eb3\",\"version\":\"MetricsItem/2.0\",\"size\":0,\"chartType\":2,\"color\":\"redBright\",\"metricScope\":0,\"resourceIds\":[\"{ApplicationInsightsResource}\"],\"timeContext\":{\"durationMs\":0},\"timeContextFromParameter\":\"TimeRange\",\"resourceType\":\"microsoft.insights/components\",\"resourceParameter\":\"ApplicationInsightsResource\",\"metrics\":[{\"namespace\":\"microsoft.insights/components/kusto\",\"metric\":\"microsoft.insights/components/kusto-Custom-customMetrics/jvm_gc_max_data_size\",\"aggregation\":4,\"splitBy\":null}],\"title\":\"Avg JVM GC Max Data Size\",\"gridSettings\":{\"rowLimit\":10000}},\"customWidth\":\"50\",\"name\":\"Avg JVM GC Max Data Size\",\"styleSettings\":{\"maxWidth\":\"50%\"}},{\"type\":10,\"content\":{\"chartId\":\"workbook492a58df-8de1-46ba-8ca3-f6535db6ff1e\",\"version\":\"MetricsItem/2.0\",\"size\":0,\"chartType\":2,\"color\":\"blue\",\"metricScope\":0,\"resourceIds\":[\"{ApplicationInsightsResource}\"],\"timeContext\":{\"durationMs\":0},\"timeContextFromParameter\":\"TimeRange\",\"resourceType\":\"microsoft.insights/components\",\"resourceParameter\":\"ApplicationInsightsResource\",\"metrics\":[{\"namespace\":\"azure.applicationinsights\",\"metric\":\"azure.applicationinsights--process_cpu_usage\",\"aggregation\":4,\"splitBy\":null}],\"title\":\"Process CPU usage\",\"gridSettings\":{\"rowLimit\":10000}},\"customWidth\":\"50\",\"name\":\"Process CPU usage\",\"styleSettings\":{\"maxWidth\":\"50%\"}},{\"type\":10,\"content\":{\"chartId\":\"workbook9d5a7d8c-9cef-452d-8b28-bbaad8b9cb40\",\"version\":\"MetricsItem/2.0\",\"size\":0,\"chartType\":0,\"metricScope\":0,\"resourceIds\":[\"{ApplicationInsightsResource}\"],\"timeContext\":{\"durationMs\":0},\"timeContextFromParameter\":\"TimeRange\",\"resourceType\":\"microsoft.insights/components\",\"resourceParameter\":\"ApplicationInsightsResource\",\"metrics\":[{\"namespace\":\"microsoft.insights/components/kusto\",\"metric\":\"microsoft.insights/components/kusto-Custom-customMetrics/jvm_classes_loaded\",\"aggregation\":4},{\"namespace\":\"microsoft.insights/components/kusto\",\"metric\":\"microsoft.insights/components/kusto-Custom-customMetrics/jvm_classes_unloaded\",\"aggregation\":4},{\"namespace\":\"microsoft.insights/components/kusto\",\"metric\":\"microsoft.insights/components/kusto-Custom-customMetrics/jvm_buffer_count\",\"aggregation\":4},{\"namespace\":\"microsoft.insights/components/kusto\",\"metric\":\"microsoft.insights/components/kusto-Custom-customMetrics/jvm_buffer_total_capacity\",\"aggregation\":4},{\"namespace\":\"microsoft.insights/components/kusto\",\"metric\":\"microsoft.insights/components/kusto-Custom-customMetrics/jvm_threads_daemon\",\"aggregation\":4}],\"title\":\"Other JVM Metrics\",\"gridFormatType\":1,\"tileSettings\":{\"showBorder\":false,\"titleContent\":{\"columnMatch\":\"Name\",\"formatter\":13},\"leftContent\":{\"columnMatch\":\"Value\",\"formatter\":12,\"formatOptions\":{\"palette\":\"auto\"},\"numberFormat\":{\"unit\":17,\"options\":{\"maximumSignificantDigits\":3,\"maximumFractionDigits\":2}}}},\"gridSettings\":{\"formatters\":[{\"columnMatch\":\"Subscription\",\"formatter\":5,\"formatOptions\":{}},{\"columnMatch\":\"Namespace\",\"formatter\":5,\"formatOptions\":{}},{\"columnMatch\":\"Metric\",\"formatter\":1,\"formatOptions\":{}},{\"columnMatch\":\"Metric ID\",\"formatter\":5,\"formatOptions\":{}},{\"columnMatch\":\"Aggregation\",\"formatter\":5,\"formatOptions\":{}},{\"columnMatch\":\"Segment Field\",\"formatter\":5,\"formatOptions\":{}},{\"columnMatch\":\"Segment\",\"formatter\":5,\"formatOptions\":{}},{\"columnMatch\":\"Value\",\"formatter\":1,\"formatOptions\":{\"aggregation\":\"Average\"}},{\"columnMatch\":\"Timeline\",\"formatter\":10,\"formatOptions\":{\"palette\":\"blue\"}},{\"columnMatch\":\"Application Insights Name\",\"formatter\":13,\"formatOptions\":{\"linkTarget\":\"Resource\",\"showIcon\":true}},{\"columnMatch\":\"Name\",\"formatter\":13,\"formatOptions\":{\"linkTarget\":\"Resource\"}}],\"rowLimit\":10000},\"sortBy\":[]},\"customWidth\":\"50\",\"name\":\"Other JVM Metrices\",\"styleSettings\":{\"maxWidth\":\"50%\"}}],\"isLocked\":false,\"fallbackResourceIds\":[\"\"]}",
          "version": "1.0",
          "sourceId": "[parameters('workbookSourceId')]",
          "category": "[parameters('workbookType')]"
        }
      }
    ],
    "outputs": {
      "workbookId": {
        "type": "string",
        "value": "[resourceId( 'microsoft.insights/workbooks', parameters('workbookId'))]"
      }
    },
    "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
  }

    DEPLOY
}

output "jvm_workbook_id1" {
    value = [for x in azurerm_template_deployment.jvmwokrbook1 : x.id]
}