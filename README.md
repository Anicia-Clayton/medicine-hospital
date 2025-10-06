# Medicine × Cloud Security – Hospital Occupancy API (Minimal AWS Stack + AWS Config)
**Goal:** Secure hospital occupancy API with encrypted storage, least-privilege IAM, and **AWS Config** runtime checks.

## Stack
- API Gateway (HTTP) → Lambda
  - `GET /v1/occupancy` → stub occupancy metrics
- DynamoDB (encrypted with KMS CMK); CloudWatch logs
- **AWS Config baseline** (recorder+delivery+managed rules + small conformance pack)

## Deploy (dev)
1) Configure backend in `infra/envs/dev/providers.tf` `backend "s3"`.
2) Build Lambda zip:
   ```bash
   cd infra/modules/api/package
   zip -r lambda.zip lambda_function.py
   ```
3) Apply:
   ```bash
   cd infra/envs/dev
   terraform init
   terraform apply -auto-approve
   ```
4) Test:
   ```bash
   curl "$API_BASE_URL/v1/occupancy"
   ```

## Security
- KMS CMK for DynamoDB SSE
- IAM least-privilege for Lambda (table-scoped)
- **AWS Config**: S3 SSE, DynamoDB KMS, Lambda no public access, S3 no public read
- tfsec workflow in `.github/workflows/terraform-security-check.yml`


## Optional: Add Cognito with MFA (recommended for staff)
1) Open `infra/examples/enable_cognito.tf` and keep the module block enabled.
2) `terraform apply`.
3) Next step: add an API Gateway **JWT authorizer** referencing the User Pool to protect the `/v1/occupancy` route.


## Optional: Protect routes with Cognito JWT authorizer
1) Ensure Cognito is enabled via `infra/examples/enable_cognito.tf` (MFA ON).
2) Enable authorizer: `infra/examples/enable_authorizer.tf` (creates `/secure/v1/*` routes protected by JWT).
3) Deploy: run `terraform apply` again.
4) Call with `Authorization: Bearer <JWT>` from your User Pool.


## Helper: Get a Cognito JWT for testing (MFA enforced)
1) Ensure Cognito (MFA=ON) and JWT authorizer are enabled.
2) Install deps and fetch a token:
```bash
cd tools
pip install -r requirements.txt
export AWS_REGION=us-east-1 USER_POOL_ID=<from outputs> APP_CLIENT_ID=<from outputs> \\
       USERNAME=nurse@example.com PASSWORD='S0meLongerP@ssw0rd!'
# If MFA required, also export MFA_CODE=123456
python get_cognito_jwt.py | jq -r .IdToken
```
3) Call a protected route:
```bash
export IDTOKEN=$(python get_cognito_jwt.py | jq -r .IdToken)
curl -H "Authorization: Bearer $IDTOKEN" "$API_BASE_URL/secure/v1/occupancy"
```
