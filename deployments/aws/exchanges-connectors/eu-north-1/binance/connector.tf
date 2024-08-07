
locals {
  artifact = "binance_futures_funding-rate_exchange-connector_rest-clickhouse@${var.build_version}.zip"
}

# ================================================               lambda

resource "aws_lambda_function" "binance_futures_funding_rate_exchange_connector_rest_clickhouse" {
  function_name = "binance-futures-funding-rate-exchange-connector-rest-clickhouse"

  runtime       = "provided.al2"
  handler       = "bootstrap"
  architectures = ["arm64"]

  package_type = "Zip"
  s3_bucket    = "veska-deploy-eu-north-1"
  s3_key       = "connectors/${local.artifact}"

  timeout     = 120
  memory_size = 128


  environment {
    variables = {
      CONNECTOR_DEBUG             = "false"
      CONNECTOR_PRODUCER_HOST     = var.clickhouse_host
      CONNECTOR_PRODUCER_DATABASE = var.clickhouse_database
      CONNECTOR_PRODUCER_USER     = var.clickhouse_user
      CONNECTOR_PRODUCER_PASSWORD = var.clickhouse_password
      CONNECTOR_PRODUCER_TABLE    = "binance_futures_funding_1h"
    }
  }

  role = var.role_arn
}


# ================================================               schedule

resource "aws_cloudwatch_event_target" "schedule_hourly_1m_target" {
  rule      = var.schedule_name
  target_id = "binance-funding-rate-connector-target"
  arn       = aws_lambda_function.binance_futures_funding_rate_exchange_connector_rest_clickhouse.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_connector" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.binance_futures_funding_rate_exchange_connector_rest_clickhouse.function_name
  principal     = "events.amazonaws.com"
  source_arn    = var.schedule_arn
}
