#!/bin/bash

# Deploy Terraform infrastructure using npm scripts and save outputs
# This script uses Terragrunt via npm scripts defined in terraform/package.json

set -e # Exit on error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "🚀 Starting Terraform deployment..."

# Change to terraform directory
cd terraform

# Initialize Terragrunt using npm script
echo "📦 Initializing Terragrunt..."
npm run dev:init

# Apply Terragrunt configuration
echo "🔧 Applying Terragrunt configuration..."
npm run dev:apply

# Extract and save outputs using terragrunt
echo "💾 Saving deployment configuration..."
cd environments/dev
S3_BUCKET_NAME=$(terragrunt output -raw s3_bucket_name)
CLOUDFRONT_DISTRIBUTION_ID=$(terragrunt output -raw cloudfront_distribution_id)
CLOUDFRONT_DOMAIN_NAME=$(terragrunt output -raw cloudfront_domain_name)
cd ../..

# Save to config file (in parent directory)
cat >../.deploy-config <<EOF
S3_BUCKET_NAME=$S3_BUCKET_NAME
CLOUDFRONT_DISTRIBUTION_ID=$CLOUDFRONT_DISTRIBUTION_ID
CLOUDFRONT_DOMAIN_NAME=$CLOUDFRONT_DOMAIN_NAME
EOF

echo "✅ Terraform deployment complete!"
echo "   S3 Bucket: $S3_BUCKET_NAME"
echo "   CloudFront Distribution: $CLOUDFRONT_DISTRIBUTION_ID"
echo "   Website URL: https://$CLOUDFRONT_DOMAIN_NAME"

cd ..