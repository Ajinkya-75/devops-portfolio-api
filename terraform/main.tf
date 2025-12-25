provider "aws" {
  region = "ap-south-1"  # Mumbai Region
}

# Create the ECR Repository (The "Parking Spot" for your Docker Image)
resource "aws_ecr_repository" "app_repo" {
  name                 = "devops-portfolio-api"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# Output the URL so we know where to push later
output "repository_url" {
  value = aws_ecr_repository.app_repo.repository_url
}

# --- NEW CODE BELOW ---

# 1. IAM Role: The "ID Card" for your Lambda
# This allows the Lambda service to assume a role to run your code
resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# 2. Permissions: Give the Role power
# Allow it to write logs to CloudWatch and read from ECR
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# 3. The Lambda Function itself
resource "aws_lambda_function" "api" {
  function_name = "devops-portfolio-api"
  role          = aws_iam_role.lambda_exec.arn
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.app_repo.repository_url}:latest"
  timeout       = 15
  memory_size   = 512

  # Ensure the role is ready before creating the function
  depends_on = [
    aws_iam_role_policy_attachment.lambda_basic
  ]
}

# 4. Public URL: Create a free HTTP endpoint so you can click it!
resource "aws_lambda_function_url" "url" {
  function_name      = aws_lambda_function.api.function_name
  authorization_type = "NONE"
}

# Output the final URL
output "function_url" {
  value = aws_lambda_function_url.url.function_url
}


# Explicitly allow the public (*) to access the Function URL
resource "aws_lambda_permission" "public_access" {
  statement_id           = "FunctionURLAllowPublicAccess_v2"
  action                 = "lambda:InvokeFunctionUrl"
  function_name          = aws_lambda_function.api.function_name
  principal              = "*"
  function_url_auth_type = "NONE"
}