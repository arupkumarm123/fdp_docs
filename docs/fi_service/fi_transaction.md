# FI Transactions
All users transactions in  FDP should be able stored in the FI service. FI service should serve the transaction data for dashboard service.
The transaction endpoints should be used by the Financial Data Providers to push transaction data in realtime. The transaction endpoint should work 
as a webhook for Data Providers to push data in realtime for more upto date data management.

## Create Transaction 
FI GW on successful pulling of transaction data will push the data to FI Service

!!! abstract "Save Transactions"

```mermaid
sequenceDiagram

participant FI GW
participant ABC GW
participant FI SVC
participant FI SVC Store

activate FI GW
FI GW ->> ABC GW: Save Transaction
activate ABC GW
ABC GW ->> ABC GW: Validate Token
ABC GW ->> FI SVC: Save Transaction
activate FI SVC
FI SVC -->> FI SVC: Validate Payload
FI SVC -->> FI GW: Transaction save Error
FI SVC ->> FI SVC Store: Save Transaction
activate FI SVC Store
FI SVC Store -->> FI SVC: Saved Transactions Response
deactivate FI SVC Store
FI SVC -->> ABC GW: Transaction Created Response
ABC GW -->> FI GW: Transaction Created Response
deactivate FI SVC
deactivate ABC GW
deactivate FI GW

```


## Get Transactions
User Dashboard or the serving layer of FDP can pull transation date from FI Service

!!! abstract "Get Transactions"

```mermaid
sequenceDiagram

participant User
participant ABC GW
participant FI SVC
participant FI SVC Store

User ->> ABC GW: Get Transactions
activate ABC GW
ABC GW ->> ABC GW: Validate Token
ABC GW ->> FI SVC: Get Transactions
activate FI SVC
FI SVC -->> FI SVC: Validate Payload
FI SVC -->> ABC GW: Transaction Get Error
FI SVC ->> FI SVC Store: Get Transactions
activate FI SVC Store
FI SVC Store -->> FI SVC: Get Transactions Response
deactivate FI SVC Store
FI SVC -->> ABC GW: Get Transactions Response
deactivate FI SVC
ABC GW -->> User: Get Transactions Response
deactivate ABC GW

```
