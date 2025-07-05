# Next.js S3 CloudFront SPA デモ

[English](README.md) | [日本語](README.ja.md)

# 💰💰💰 CloudFrontファンクション不要 = 最大限のコスト削減 💰💰💰

## 🚫 Lambda@Edge不要 🚫 CloudFrontファンクション不要 🚫 ファンクションコスト不要

AWS S3 + CloudFrontでNext.jsをシングルページアプリケーションとしてデプロイするコスト効率的なデモ。

🚀 **ライブデモ**: https://d1ntce1o7au93y.cloudfront.net/

## 💸 このデモがコストを削減する理由 💸

### ❌ 通常のアプローチ（高コスト）：

- URLリライトにCloudFrontファンクションを使用
- ルーティングにLambda@Edgeを使用
- 100万実行ごとに課金
- 複雑なセットアップとメンテナンス

### ✅ このプロジェクトの仕組み（コスト効率的）：

- **ファンクション不要** - CloudFrontファンクションやLambda@Edgeを一切使用しない
- CloudFrontの**無料**ビルトインエラーページ処理を使用
- トラフィック量に関わらず実行コストなし
- シンプルな設定

## 主な機能

- ✅ **CloudFrontファンクション不要** - Lambda@EdgeやCloudFrontファンクションの代わりにCloudFrontのビルトインエラーページ処理を使用
- ✅ **コスト効率的** - ファンクション実行コストがゼロ
- ✅ **シンプルな実装** - 最小限の設定で済む

## 仕組み

このデモは、CloudFrontのカスタムエラーページを使用して、ファンクションなしでSPAルーティングを処理します：

```hcl
# CloudFrontはすべての403/404エラーに対して404.htmlを返します - ファンクション不要！
custom_error_response {
  error_code         = 404
  response_code      = 200
  response_page_path = "/404.html"
}
```

## 💰 コスト比較

| ソリューション | CloudFrontファンクション | Lambda@Edge | この方式 |
| -------------- | ------------------------ | ----------- | ---------- |
| ファンクションコスト | 100万実行あたり$0.10 | 100万実行あたり$0.60 | **$0.00** 🎉 |
| セットアップの複雑さ | 中 | 高 | **低** |
| メンテナンス | 必要 | 必要 | **不要** |

## 実装

実装の詳細については、以下を参照してください：

- [`next.config.ts`](./next.config.ts) - Next.js静的エクスポート設定
- [`app/not-found.tsx`](./app/not-found.tsx) - SPAルーティング用の404エラーページ
- [`deploy-s3.sh`](./deploy-s3.sh) - S3デプロイメントスクリプト

## クイックスタート

### 前提条件

Terraformバックエンド用のSSM Parameter Storeを作成：
```bash
# 形式: /terraform/{プロジェクト名}/{環境}/backend-config
aws ssm put-parameter --name "/terraform/your-project-name/dev/backend-config" \
  --type "String" \
  --value '{"bucket":"your-terraform-state-bucket","region":"us-east-1","dynamodb_table":"your-lock-table","role_arn":""}'
```

### デプロイ

```bash
# すべてをデプロイ
./deploy.sh
```

これだけです！複雑なセットアップ不要、CloudFrontファンクション不要、シンプルでコスト効率的なSPAデプロイメントです。

## ライセンス

MIT