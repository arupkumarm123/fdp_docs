
# FI Account Onboarding
All users of FDP should be able to pull in account details from a finanicial data provider which has onboarded to FDP.
First step of data extraction from a Data Provider is to link the User Account with the FDP. The part of the linking
is to retrieve and store users credential for doing further data extraction.


## Security 
For all link , unlink  , data import calls the users credential is to be provided to the Financial Data Provider. Suggested ABC install a cred service to
securely store user cred (password/access token). Cred Service can install a vault to securely store  user credential. Also ABC should establish its credential
with the Financial Data Provider . Offline ABC should onboard on to the Financial Data Provider by a ouath clieent credential method. All calls should provide the Aceestoken
provided by client credential grant to access data securedly .

## Linking Account 
Create a link between the account on FDP side with the account on financial data provider with ABC.

!!! abstract "Link Account"

```mermaid
sequenceDiagram

participant User
participant ABC GW
participant FI GW
participant FI SVC
participant Cred Service
participant FI DP
participant FI SVC Store

activate User
User ->> ABC GW: Link Account 
activate ABC GW
ABC GW ->> ABC GW: Validate Token
ABC GW ->> FI GW: Link Account
activate FI GW
FI GW -->> FI GW: Validate Payload
FI GW -->> User: Onboarding Error
FI GW ->> FI SVC: Intg Meta 
activate FI SVC
FI SVC -->> FI GW: Intg Meta
FI GW ->> FI GW: Find Integration Router
FI GW ->> FI DP: Link Account
activate FI DP
FI DP -->> FI GW: Account + Access Credential
deactivate FI DP
FI GW ->> Cred Service: Save Credential
activate Cred Service
Cred Service -->> FI GW: Cred Saved
deactivate Cred Service
FI GW -->> FI GW: Data Conversion
FI GW -->> FI SVC: Save Account
activate FI SVC Store
FI SVC ->> FI SVC Store: Save Account
FI SVC Store -->> FI SVC: Account ID
deactivate FI SVC Store
FI SVC -->> FI GW: Account Created Response
deactivate FI SVC
FI GW -->> ABC GW: Account Created Response
ABC GW --> User: Account Created Response
deactivate FI GW
deactivate ABC GW
deactivate User
```

!!! abstract "Example Link Account"

```
curl  -XPOST http://localhost:8060/figw-service/fi/{fiid}/account/{accountID} 
  -d '{
        "usercred" : <> , 
        "bankID" : 4 , 
        "accountNumber" : 4001 , 
        "accountType" : "SAVINGS" 
      }' 
  -H "Content-Type: application/json" -H "Authorization: Bearer <System Access Token>"
```



## UnLinking Account 
User can choose to delink an account sync for a particular service provider.

!!! abstract "UnLink Account"

```mermaid
sequenceDiagram

participant User
participant ABC GW
participant FI GW
participant FI SVC
participant FI DP
participant FI SVC Store

activate User
User ->> ABC GW: UnLink Account 
activate ABC GW
ABC GW ->> ABC GW: Validate Token
ABC GW ->> FI GW: Unlink Account
activate FI GW
FI GW -->> FI GW: Validate Payload
FI GW -->> User: Unlinking Error
FI GW ->> FI SVC: Get FI Meta
activate FI SVC
FI SVC ->> FI GW: FI Meta
FI GW -->> FI GW: Find Adapter
FI GW ->> FI DP: Unlink Account
activate FI DP
FI DP -->> FI GW:  Unlink Status
deactivate FI DP
FI GW ->> Cred Service: Delete Credential
activate Cred Service
Cred Service -->> FI GW: Credential Deleted
deactivate Cred Service
FI GW -->> FI SVC: Delete Account
FI SVC ->> FI SVC Store: Delete Account
activate FI SVC Store
FI SVC Store -->> FI SVC: Delete Account ID
deactivate FI SVC Store
FI SVC -->> FI GW: Account Deleted Response
deactivate FI SVC
FI GW -->> ABC GW: Account Deleted Response
deactivate FI GW
ABC GW --> User: Account Deleted Response
deactivate ABC GW
deactivate User
```

!!! abstract "Example Delete Linked Account"

```
curl  -XPOST http://localhost:8060/figw-service/fi/{fiid}/account/{accountID} 
  -d '{
        "customerID" : 4 , 
        "bankID" : 4 , 
        "accountNumber" : 4001 , 
        "accountType" : "SAVINGS" 
      }' 
  -H "Content-Type: application/json" -H "Authorization: Bearer <System Access Token>"
```
