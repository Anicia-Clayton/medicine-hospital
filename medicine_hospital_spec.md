# Medicine × Cloud Security (Hospital Occupancy API)
**One-page spec**

**Goal:**  
Design a HIPAA-aligned occupancy API that exposes hospital bed data securely to authorized staff and enforces compliance drift monitoring.

**What you’ll build:**  
A compliant serverless API that shows real-time bed availability while enforcing identity verification and continuous configuration auditing.

**AWS (≤6):**  
API Gateway, Lambda, DynamoDB (bed-status table), Cognito (MFA), AWS Config (HIPAA baseline/CIS pack), KMS.

---

### **Success metrics**
- Cognito MFA mandatory for staff sign-in.  
- DynamoDB encrypted with CMK; no public access.  
- AWS Config: detects non-encrypted or non-compliant resources within minutes.  
- tfsec scan: 0 high/critical findings.  
- CloudWatch Logs capture all API/Lambda activity.  

---

### **Deliverables**
- DynamoDB table: `hospital_beds` (partition key: ward_id).  
- Lambda functions for read/update occupancy status.  
- Cognito user pool (staff only) + MFA enforced.  
- IAM policy: scoped to single table actions.  
- AWS Config rules (encryption, IAM key rotation, no public endpoints).  
- CloudWatch + CloudTrail logging enabled.  
- tfsec report + compliance summary note.  

---

### **2-week sprint**
- **Day 1–2:** Model API routes; seed DynamoDB with sample bed data.  
- **Day 3–4:** Build Lambda & API Gateway; add input validation.  
- **Day 5:** Configure Cognito MFA; JWT authorizer; least-privilege IAM.  
- **Day 6:** Add KMS encryption; deploy AWS Config rules.  
- **Day 7–8:** Validate compliance alerts (Config + CloudWatch).  
- **Day 9:** Run tfsec; fix issues; generate reports.  
- **Day 10:** Demo + export artifacts; backlog (auto-remediation Lambda, GuardDuty).

