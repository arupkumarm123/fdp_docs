
# FI Transaction import
All users transactions in  FDP need to be pulled from a Financial data provider.Financial Data Provider during its onboarding has
provide details of Endpoints and also Metadata of the objects. As part of the account linking the FIGW should pull the Credential
needed to pull data from the Financial Data Provider. The credential need to be securedly stored in a cred service backed by a data vault.
Data sync can be initiated by the user , schedule or via webhooks. Webhooks can be a recommended way for more accurate and reatime data sync.
The financial data provider should access the webhook to post realtime updates to user account.

## Create Transaction 
FI GW on successful pulling of transaction data will push the data to FI Service

!!! abstract "Save Transactions"

```mermaid
sequenceDiagram

participant User
participant ABC GW
participant FI GW
participant FI SVC
participant Cred Service
participant FI DP

activate User
activate FI GW

User ->> ABC GW: Get Transactions
activate ABC GW
ABC GW ->> ABC GW: Validate Token
ABC GW ->> FI GW: Get Transactions
activate FI GW
FI GW -->> FI GW: Validate Payload
FI GW -->> ABC GW: Payload Validation Error
FI GW ->> FI SVC: FI Meta
activate FI SVC
FI SVC -->> FI GW: FI Meta
deactivate FI SVC
FI GW ->> Cred Service: Get Access Token
activate Cred Service
Cred Service -->> FI GW: System + User Access Token
deactivate Cred Service
FI GW -->> FI GW: Resolve Adapter
FI GW ->> FI DP: Get Transactions
activate FI DP
FI DP -->> FI GW: Transactions
deactivate FI DP
activate FI SVC
FI GW ->> FI SVC: Save Transactions
deactivate FI SVC
FI GW -->> ABC GW: Transactions
deactivate FI GW
ABC GW -->> User: Transactions
deactivate ABC GW
deactivate User

```


