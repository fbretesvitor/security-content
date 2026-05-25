# KQL Queries

This folder contains Kusto Query Language (KQL) queries for Azure Log Analytics and Microsoft Sentinel.

## Overview

KQL queries in this folder are designed to:
- Detect security threats and anomalies
- Investigate incidents and security events
- Monitor data ingestion and performance
- Support hunting and analytics activities

## File Naming

All query files use the `.kql` extension. Use descriptive names that indicate the query's purpose:
- Example: `detect-suspicious-login-attempts.kql`
- Example: `investigate-malware-indicators.kql`

## Query Structure

Each query should include:
1. A comment header describing the query's purpose
2. Required tables and data sources
3. Clear filtering and aggregation logic
4. Appropriate time ranges for the use case

Example:
```kql
// Purpose: Detect failed login attempts from unusual locations
// Tables: SigninLogs
SecurityEvent
| where EventID == 4625
| summarize FailureCount = count() by SourceIpAddress, Account