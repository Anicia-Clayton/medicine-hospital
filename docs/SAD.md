# Solutions Architecture Document (SAD)
## Project: Medicine × Cloud Security (Hospital Occupancy API)

### 1. Overview
HIPAA-aligned API providing hospital bed availability to authorized staff.  
Protects patient-associated data with encryption, MFA, and compliance drift monitoring.

### 2. Goals
- Enforce HIPAA-aligned access control (Cognito MFA).
- Detect and remediate noncompliance automatically.
- Maintain encryption at rest and in transit.

### 3. Architecture Summary
**Pattern:** Serverless secure data access API.  
**Stack:** API Gateway → Lambda → DynamoDB (KMS) + Cognito (MFA) + AWS Config + CloudWatch.

### 4. Data Flow
1. Staff login via Cognito MFA.  
2. API Gateway authorizes JWT and routes request.  
3. Lambda reads/writes bed data in encrypted DynamoDB.  
4. Config & CloudWatch track compliance and anomalies.

### 5. Key AWS Services
| Layer | Service | Purpose |
|-------|----------|----------|
| Identity | Cognito | MFA-authenticated access |
| Compute | Lambda | Process occupancy updates |
| Storage | DynamoDB (KMS) | Encrypt hospital data |
| Compliance | AWS Config | Runtime compliance checks |
| Monitoring | CloudWatch | Log and alert runtime activity |

### 6. Security & Compliance
- AWS Config HIPAA-aligned ruleset (CIS + encryption + IAM key rotation).  
- CloudWatch logs for auditing API activity.  
- tfsec scanning in CI/CD.  
- Lambda auto-remediation for drifted resources.

### 7. Future Enhancements
- Integrate AWS Security Hub for compliance aggregation.  
- Expand Config rules to cover EBS and VPC flow logs.  
- Add GuardDuty for anomaly detection.
