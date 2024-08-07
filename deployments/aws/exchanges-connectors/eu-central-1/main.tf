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


# ================================================               policy

data "aws_iam_role" "connectors_iam_role" {
  name = "connectors-iam-role"
}


# ================================================               schedule

resource "aws_cloudwatch_event_rule" "schedule_hourly_1m" {
  name                = "schedule-hourly-1m"
  schedule_expression = "cron(1 * * * ? *)"
}


# ================================================               connectors

module "binance_futures_oi_restc" {
  source = "./binance"

  build_version = var.BINANCE_FUTURES_OPEN-INTEREST_EXCHANGE-CONNECTOR_REST-CLICKHOUSE

  role_arn      = data.aws_iam_role.connectors_iam_role.arn
  schedule_arn  = aws_cloudwatch_event_rule.schedule_hourly_1m.arn
  schedule_name = aws_cloudwatch_event_rule.schedule_hourly_1m.name

  clickhouse_host     = var.CLICKHOUSE_HOST
  clickhouse_database = var.CLICKHOUSE_DATABASE
  clickhouse_user     = var.CLICKHOUSE_USER
  clickhouse_password = var.CLICKHOUSE_PASSWORD
}


module "bybit_futures_oi_restc" {
  source = "./bybit"

  build_version = var.BYBIT_FUTURES_OPEN-INTEREST_EXCHANGE-CONNECTOR_REST-CLICKHOUSE

  role_arn      = data.aws_iam_role.connectors_iam_role.arn
  schedule_arn  = aws_cloudwatch_event_rule.schedule_hourly_1m.arn
  schedule_name = aws_cloudwatch_event_rule.schedule_hourly_1m.name

  clickhouse_host     = var.CLICKHOUSE_HOST
  clickhouse_database = var.CLICKHOUSE_DATABASE
  clickhouse_user     = var.CLICKHOUSE_USER
  clickhouse_password = var.CLICKHOUSE_PASSWORD
}
