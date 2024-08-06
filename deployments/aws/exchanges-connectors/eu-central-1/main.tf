terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "veska-deploy-eu-central-1"
    key    = "terraform/connectors-state/main.tfstate"
    region = "eu-central-1"
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_object_copy" "copy_oi_artifact" {
  bucket = "veska-deploy-eu-central-1"
  key    = "connectors/binance_futures_open-interest_exchange-connector_rest-clickhouse@${var.BINANCE_FUTURES_OPEN-INTEREST_EXCHANGE-CONNECTOR_REST-CLICKHOUSE}.zip"
  source = "veska-deploy-eu-north-1/connectors/binance_futures_open-interest_exchange-connector_rest-clickhouse@${var.BINANCE_FUTURES_OPEN-INTEREST_EXCHANGE-CONNECTOR_REST-CLICKHOUSE}.zip"
}


# ================================================               policy

data "aws_iam_role" "connectors_iam_role" {
  name = "connectors-iam-role"
}

# ================================================               schedule

resource "aws_cloudwatch_event_rule" "schedule_hourly_1m" {
  name                = "schedule-hourly-1m"
  schedule_expression = "cron(1 * * * ? *)"
}

resource "aws_cloudwatch_event_target" "schedule_hourly_1m_target" {
  rule      = aws_cloudwatch_event_rule.schedule_hourly_1m.name
  target_id = "binance-open-interest-connector-target"
  arn       = aws_lambda_function.binance_futures_oi_exchange_connector_rest_clickhouse.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_connector" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.binance_futures_oi_exchange_connector_rest_clickhouse.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.schedule_hourly_1m.arn
}

# ================================================               lambda

resource "aws_lambda_function" "binance_futures_oi_exchange_connector_rest_clickhouse" {
  function_name = "binance-futures-open-interest-exchange-connector-rest-clickhouse"

  runtime       = "provided.al2"
  handler       = "bootstrap"
  architectures = ["arm64"]

  package_type = "Zip"
  s3_bucket    = "veska-deploy-eu-central-1"
  s3_key       = "connectors/binance_futures_open-interest_exchange-connector_rest-clickhouse@${var.BINANCE_FUTURES_OPEN-INTEREST_EXCHANGE-CONNECTOR_REST-CLICKHOUSE}.zip"

  timeout     = 120
  memory_size = 128


  environment {
    variables = {
      CONNECTOR_DEBUG             = "false"
      CONNECTOR_PRODUCER_HOST     = var.CLICKHOUSE_HOST
      CONNECTOR_PRODUCER_DATABASE = var.CLICKHOUSE_DATABASE
      CONNECTOR_PRODUCER_USER     = var.CLICKHOUSE_USER
      CONNECTOR_PRODUCER_PASSWORD = var.CLICKHOUSE_PASSWORD
      CONNECTOR_PRODUCER_TABLE    = "binance_futures_open_interest_1h"
    }
  }

  role = data.aws_iam_role.connectors_iam_role.arn

  depends_on = [aws_s3_object_copy.copy_oi_artifact]
}
