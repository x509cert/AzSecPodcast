Designing and Developing Secure Azure Solutions Table of Contents

Page counts are approximate

## Forward by Scott Guthrie (1pp)

## Introduction (3pp)

## 1 Secure Development Lifecycle Processes (20pp)

-   Starting with the Microsoft SDL
-   Securing Features vs Security Features
-   The SDL Components
-   SDL Tasks by Sprint
-   The Human Element

# PART 1 – SECURE DESIGN

## 2 Secure Design (23pp)

-   The Cloud DevOps and Security
-   PaaS vs IaaS and Shared Responsibility
-   Zero Trust for Developers
-   Thinking about secure design
-   Security Design Principles applied to Azure
    -   Attack Surface Reduction
    -   Complete Mediation
    -   Economy of Mechanisms
    -   Golden Rules (Au\*)
    -   Defense in Depth
    -   Fail Safe Defaults
    -   Fails Secure
    -   Least Common Mechanism
    -   Least Privilege
    -   Leveraging Existing Components
    -   Separation of Duties
    -   Open Design
    -   Psychological Acceptability
    -   Single Point of Failure
    -   Weakest Link

## 3 Security Patterns (31pp)

-   What is a Pattern?
-   Authentication Patterns
-   Authorization patterns
-   Secrets Management Patterns
-   Sensitive Information Management Patterns
-   Availability Patterns

## 4 Threat Modeling (42pp)

-   What is threat modeling?
-   Microsoft STRIDE threat modeling
-   The Trouble with threat modeling
-   A better way to perform threat modeling
-   Your choice of threat modeling tools
    -   CAIRIS
    -   Microsoft Threat Modeling Tool
    -   OWASP Threat Dragon
    -   Pytm
    -   Threagile
    -   Threats Manager Studio
-   How to threat model a real-life example

## 5 Identity, Authentication & Authorization (50pp)

-   AuthN vs AuthZ vs Identity
-   Modern Identity and Access Management
-   Fundamentals of OpenID Connect and OAuth2
-   MSAL Libraries
-   Flows
-   Security implications of various OAuth flows
-   Client Types
-   Tokens
-   Scopes, Permissions and Consent
-   Anatomy of a JWT Token
-   Authentication
    -   Who is authenticating whom?
    -   Multi-factor Authentication
    -   The Role of Single Sign On
    -   Authenticating to Azure Resources
    -   Getting Access without Authenticating
-   Authorization
    -   RBAC
    -   Azure AD Roles and Scopes
    -   Azure Control Plane RBAC
    -   Managing Role Assignment
    -   Custom Role Definitions and Limits
    -   Deny Assignments
    -   Best Practices
    -   Azure AD Privileged Access Management
    -   ABAC

## 6 Monitoring and Audit (30pp)

-   Monitoring, Auditing, Logging, oh my!
-   Leveraging the Platform
-   Log Analytics
-   Kusto Queries
-   Raising alerts
-   From alerts to action
-   Protecting the audit logs
    -   Immutable Storage
-   Taming costs
-   The need for intentional security monitoring and auditing
-   The role of threat model
-   Alerts from custom events on Azure Sentinel

## 7 Governance (13pp)

-   Azure Security Benchmark and Baselines
-   Governance Enforcement
-   Microsoft Defender for Cloud
-   Azure Policy, Blueprints and Compliance

## 8 Compliance & Risk (26pp)

-   Your company’s compliance requirements
-   Common Compliance/Risk Programs
    -   HIPAA
    -   HITRUST
    -   GDPR
    -   PCI DSS
    -   FedRAMP
    -   NIST SP 800-53
    -   NIST CSF
    -   FIPS 140
    -   SOC
    -   ISO 27001
    -   ISO 27034
    -   CSA
    -   CIS
    -   ASB
    -   MITRE
-   Compliance and threat models

# PART 2: SECURE IMPLEMENTATION

## 9 Secure Coding (56pp)

-   Rule \#1 – All Input is Evil
-   Using Threat Models
-   Determining Correctness
-   Common Vulnerabilities and Remedies
-   Comments about C++
-   Security Code Review
-   Fuzz testing

## 10 Cryptography (88pp)

-   Securing Keys
-   Key Vault and Managed HSM in Depth
    -   AKV RBAC Models
-   Crypto Agility
-   MS Data Encryption SDK
-   Cryptography is various Azure Services
-   Volume vs Object crypto
-   Key Rotation
-   Protecting Data in Transit
    -   TLS Ciphersuites
    -   TLS in IaaS
    -   TLS in PaaS
    -   Debugging TLS
    -   SSH

## 11 Confidential Computing (14pp)

-   Intel Software Guard Extensions
-   AMD Secure Encrypted Virtualization-Secure Nested Paging
-   Arm TrustZone
-   DCsv3 Series VMs
-   Keys
-   Attestation
-   Malware in TEEs
-   Trusted Launch for VMs
-   Azure Services that use Confidential Computing
    -   SQL Server Always Encrypted
    -   Azure Confidential Ledger
    -   Confidential Containers
-   A Reference Architecture

## 12 Container Security (18pp)

-   What are containers?
-   Container Services on Azure
    -   Comparisons
        -   Azure Functions Containers
        -   Azure Container Instances
        -   Azure Container Apps
        -   Azure Kubernetes Services
        -   Azure Confidential Containers
        -   Managed OpenShift
-   The Problems with Containers
-   Securing Container Services
    -   Development and Deployment
    -   The Container Registry
    -   The Cluster
    -   The Nodes
    -   The Pods and Containers
    -   The Application

## 13 Database Security (46pp)

-   Why Database Security?
-   Thinking about Database Security
-   The SQL Server Family
    -   Control Plane Authentication
        -   Server AuthN
        -   Client AuthN
    -   Control Plane Authorization
    -   Control Plane Audit
    -   Control Plane Crypto on the wire
    -   Control Plane Network Isolation
    -   Data Plane Authentication
        -   Server AuthN
        -   Client AuthN
    -   Data Plane Authorization
    -   Data Plane Audit
    -   Data Plane Crypto on the wire
    -   Data Plane Network Isolation
    -   Cryptographic controls for data at rest
        -   Transparent Data Encryption
        -   Column Encryption
        -   Always Encrypted
    -   Miscellaneous
        -   Dynamic Data Masking
        -   Data Discovery and Classification
        -   Azure SQL Ledger
        -   Microsoft Defender for SQL
        -   Azure Security Baseline
-   Cosmos DB Security
    -   Control Plane Authentication
        -   Server AuthN
        -   Client AuthN
    -   Control Plane Authorization
    -   Control Plane Audit
    -   Control Plane Crypto on the wire
    -   Control Plane Network Isolation
    -   Data Plane Authentication
        -   Server AuthN
        -   Client AuthN
    -   Data Plane Authorization
    -   Data Plane Audit
    -   Data Plane Crypto on the wire
    -   Data Plane Network Isolation
    -   Cryptographic controls for data at rest
        -   Transparent Data Encryption
        -   Always Encrypted
    -   Miscellaneous
        -   Microsoft Defender for Cosmos DB
        -   Azure Security Baseline
-   Encryption of Data in Use – Always Encrypted
    -   Always Encrypted
    -   Always Encrypted with Secure Enclaves
    -   Attestation
    -   Cosmos DB and Always Encrypted
        -   Setup Key Vault
        -   Connect to Cosmos DB
        -   Create a data encryption key
        -   Set the Container Cryptographic Policy
-   SQL Injection

## 14 Deployment (HG, 30pp, 21d)

-   Deployment through CI/CD
-   Securing CI/CD Pipelines
-   Container security
-   Separation of duties
-   Secure use of ARM and Bicep (Terraform?)
-   Show deploying a Function/Managed ID/AKV

## 15 Network Security for Developers (Approx 22pp)

-   Azure Networking Primer
    -   IPv4, IPv6 in Azure
    -   IPv4 Addresses in Azure
    -   Routing and User Defined Routes (UDR)
    -   Network Security Groups (NSG)
    -   Application Security Groups (ASG)
-   Landing Zones, Hub and Spoke
    -   Hub and Spoke and Segmentation
    -   Environment segregation, VNETs and allowed Communications
    -   Ingress and Egress Controls
-   Network Virtual Appliances (NVA) and Gateways
    -   Azure Firewall
    -   Azure Web Application Firewalls
    -   API Management (APIM) Gateway
    -   Azure App Proxy
-   PaaS and Private Networking
    -   Endpoints – Public or Private
    -   Dedicated PaaS Instances
    -   Managed VNETs
    -   Agent-Based Network Participation
-   Azure Kubernetes Service and Networking
-   The Private DNS Problem
-   The Dangling DNS Problem

## Appendix A – Basic Cryptography (8pp)

-   Symmetric Secrecy
-   Asymmetric Secrecy
-   Symmetric integrity/authentication
-   Asymmetric integrity/authentication
-   Symmetric Ciphers
-   Asymmetric Ciphers
-   Hashes
-   Message Authentication Codes
-   Digital Signatures
-   Certificates
-   Key Derivation

## Afterward
