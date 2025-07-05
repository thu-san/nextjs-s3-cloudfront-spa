# Next.js S3 CloudFront SPA Demo

[English](README.md) | [日本語](README.ja.md)

# 💰💰💰 ZERO CLOUDFRONT FUNCTIONS = MAXIMUM COST SAVINGS 💰💰💰

## 🚫 NO Lambda@Edge 🚫 NO CloudFront Functions 🚫 NO Function Costs

A cost-effective demo for deploying Next.js as a single-page application on AWS S3 + CloudFront.

🚀 **Live Demo**: https://d1ntce1o7au93y.cloudfront.net/

## 💸 Why This Demo Saves You Money 💸

### ❌ Normal Approach (EXPENSIVE):

- Use CloudFront Functions for URL rewriting
- Use Lambda@Edge for routing
- Pay per million function executions
- Complex setup and maintenance

### ✅ What This Project Does (COST-EFFECTIVE):

- **ZERO FUNCTIONS** - Absolutely no CloudFront Functions or Lambda@Edge
- Uses CloudFront's **FREE** built-in error page handling
- No execution costs, no matter how much traffic you get
- Dead simple configuration

## Key Features

- ✅ **No CloudFront Functions** - Uses CloudFront's built-in error page handling instead of Lambda@Edge or CloudFront Functions
- ✅ **Cost Effective** - Zero function execution costs
- ✅ **Simple Implementation** - Minimal configuration required

## How It Works

This demo uses CloudFront's custom error pages to handle SPA routing without any functions:

```hcl
# CloudFront returns 404.html for all 403/404 errors - no functions needed!
custom_error_response {
  error_code         = 404
  response_code      = 200
  response_page_path = "/404.html"
}
```

## 💰 Cost Comparison

| Solution         | CloudFront Functions | Lambda@Edge       | This Method |
| ---------------- | -------------------- | ----------------- | ------------ |
| Function Cost    | $0.10 per million    | $0.60 per million | **$0.00** 🎉 |
| Setup Complexity | Medium               | High              | **Low**      |
| Maintenance      | Required             | Required          | **None**     |

## Implementation

For implementation details, see:

- [`next.config.ts`](./next.config.ts) - Next.js static export configuration
- [`app/not-found.tsx`](./app/not-found.tsx) - 404 error page for SPA routing
- [`deploy-s3.sh`](./deploy-s3.sh) - S3 deployment script

## Quick Start

### Prerequisites

Create SSM Parameter Store for Terraform backend:
```bash
# Format: /terraform/{project-name}/{environment}/backend-config
aws ssm put-parameter --name "/terraform/your-project-name/dev/backend-config" \
  --type "String" \
  --value '{"bucket":"your-terraform-state-bucket","region":"us-east-1","dynamodb_table":"your-lock-table","role_arn":""}'
```

### Deploy

```bash
# Deploy everything
./deploy.sh
```

That's it! No complex setup, no CloudFront Functions, just a simple and cost-effective SPA deployment.

## License

MIT
