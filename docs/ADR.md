# Architecture Decision Record (ADR)
## Project: Medicine × Cloud Security (Hospital Occupancy API)

### ADR-001: Enforce MFA via Cognito
**Context:** Healthcare data requires strong authentication.  
**Decision:** Use Cognito with mandatory MFA.  
**Rationale:** Aligns with HIPAA technical safeguards.

### ADR-002: Implement Runtime Compliance & Remediation
**Context:** Must detect and fix misconfigurations automatically.  
**Decision:** AWS Config + Lambda auto-remediation.  
**Rationale:** Ensures rapid correction of compliance drift.

### ADR-003: Encrypt All Storage Layers
**Context:** Protect patient-related data and prevent data exposure.  
**Decision:** Use KMS CMK for DynamoDB SSE and TLS 1.2+.  
**Rationale:** Meets HIPAA encryption and confidentiality requirements.

### ADR-004: Add CloudWatch for Auditing
**Context:** Need traceability for API usage.  
**Decision:** Log all API requests/responses.  
**Rationale:** Supports auditability and compliance reporting.
