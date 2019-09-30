# FI Seat Management
Offline process should provide client credential for the bank to use the credential for Seat Management.Standard oauth access token with admin scope should be used for seat management.

##FI
Create a banking or financial instituite as a data provider with ABC.

!!! abstract "Create FI"

```mermaid
sequenceDiagram

participant Bank Admin User
participant ABC API GW
participant FI SVC
activate Bank Admin User
Bank Admin User ->> ABC API GW: Onboard FI
activate ABC API GW
ABC API GW ->> ABC API GW: Validate Token
activate FI SVC
ABC API GW -->> FI SVC: Create Account
FI SVC -->> FI SVC: Validate Payload
FI SVC ->> FI SVC Store: Save Account
FI SVC Store -->> FI SVC: Account ID
FI SVC -->> ABC API GW: Account Created Response
ABC API GW -->> Bank Admin User: Account Created Response
deactivate ABC API GW
deactivate Bank Admin User
```

!!! abstract "Example Create FI"
```
curl -XPOST  http://localhost:8060/fi-service/fi 
  -d '{ "name" : "citibank" , 
        "address" :"New York" , 
        "intMethod" : "PROVIDED" , 
        "authType" : "OAUTH" 
      }' 
  -H "Content-Type: application/json" -H "Authorization: Bearer <System Access Token>"
```



!!! abstract "Update FI"
Admin user of the financial institute should be able to update details about the seat.

```mermaid
sequenceDiagram

participant Bank Admin User
participant ABC API GW
participant FI SVC
activate Bank Admin User
Bank Admin User ->> ABC API GW: GET Seat Details
activate ABC API GW
ABC API GW ->> ABC API GW: Validate Token
activate FI SVC
ABC API GW -->> FI SVC: Update Account
FI SVC -->> FI SVC: Validate Payload
FI SVC ->> FI SVC Store: Update Account
FI SVC Store -->> FI SVC: Updated Account
FI SVC -->> ABC API GW: Account Updated Response
ABC API GW -->> Bank Admin User: Account Updated Response
deactivate ABC API GW
deactivate Bank Admin User
```

!!! abstract "Example Update FI"
```
curl -XPATCH  http://localhost:8060/fi-service/fi/BankA
  -d '{ 
        "address" :"New York" 
      }' 
  -H "Content-Type: application/json" -H "Authorization: Bearer <System Access Token>"
```

!!! abstract "Retrieve FI"
Admin user of the financial institute should be able to get details about the seat.

```mermaid
sequenceDiagram

participant Bank Admin User
participant ABC API GW
participant FI SVC
activate Bank Admin User
Bank Admin User ->> ABC API GW: GET FI Details
activate ABC API GW
ABC API GW ->> ABC API GW: Validate Token
activate FI SVC
ABC API GW -->> FI SVC: Get Seat Details
FI SVC ->> FI SVC Store: Retrieve Seat Details
FI SVC Store -->> FI SVC: Seat Details
FI SVC -->> ABC API GW: Seat Details Response
ABC API GW -->> Bank Admin User: Seat Details Response
deactivate ABC API GW
deactivate Bank Admin User
```

!!! abstract "Example Retrieve FI"
```
curl -XGET  http://localhost:8060/fi-service/fi/123
  -H "Content-Type: application/json" -H "Authorization: Bearer <System Access Token>"
```

## Endpoints
Admin user of the financial institute should be able to define the integration mechanism for accessing data.
Endpoint represents an access definition for a particular type of data(Account , Transaction,Statement, Tax Statement)
Endpoints represent a collection of all the Endpoint Objects. First and Endpoints collection is created and than 
Endpoint is attached to the Endpoints Collection


!!! abstract "FI Endpoints Definition"

```mermaid
sequenceDiagram

participant Bank Admin User
participant ABC API GW
participant FI SVC
activate Bank Admin User
Bank Admin User ->> ABC API GW: Save EndPoints Details
activate ABC API GW
ABC API GW ->> ABC API GW: Validate Token
activate FI SVC
ABC API GW -->> FI SVC: Save Endpoints 
FI SVC ->> FI SVC Store: Save Endpoints 
FI SVC Store -->> FI SVC: Endpoints
FI SVC -->> ABC API GW: EndPoints 
ABC API GW -->> Bank Admin User: EndPoints 
deactivate ABC API GW
deactivate Bank Admin User
```

!!! abstract "Example Create Endpoints Collection"
```
 curl  -XPOST http://localhost:8060/fi-service/fi/3/endpoints 
 -d '{
        "name" : "FI" , 
        "desc" : "fi integration" , 
        "fiID" : 3
     }' 
  -H "Content-Type: application/json" -H "Authorization: Bearer <System Access Token>"
```

!!! abstract "FI Endpoints Details"

```mermaid
sequenceDiagram

participant Bank Admin User
participant ABC API GW
participant FI SVC
activate Bank Admin User
Bank Admin User ->> ABC API GW: Get EndPoints Details
activate ABC API GW
ABC API GW ->> ABC API GW: Validate Token
activate FI SVC
ABC API GW -->> FI SVC: Get Endpoints Details
FI SVC ->> FI SVC Store:  Endpoints 
FI SVC Store -->> FI SVC: Endpoints
FI SVC -->> ABC API GW: EndPoints 
ABC API GW -->> Bank Admin User: EndPoints 
deactivate ABC API GW
deactivate Bank Admin User
```

## Endpoint

Endpoint integration mechanism for a particular entity(Account, Transaction, Statement, Tax Statement).

!!! abstract "FI Endpoint Definition"

```mermaid
sequenceDiagram

participant Bank Admin User
participant ABC API GW
participant FI SVC
activate Bank Admin User
Bank Admin User ->> ABC API GW: Save EndPoints Details
activate ABC API GW
ABC API GW ->> ABC API GW: Validate Token
activate FI SVC
ABC API GW -->> FI SVC: Save Endpoint 
FI SVC ->> FI SVC Store: Save Endpoint 
FI SVC Store -->> FI SVC: Endpoint
FI SVC -->> ABC API GW: EndPoint 
ABC API GW -->> Bank Admin User: EndPoint 
deactivate ABC API GW
deactivate Bank Admin User
```

!!! abstract "Example Create EndPoint"
```

 curl  -XPOST http://localhost:8060/fi-service/fi/3/endpoints/link  
 -d '{ 
        "endPointType" : "LINK" , 
        "type" : "API" , 
            "serviceDef" : {
               "url" : "http://localhost:9090/account", 
               "method" : "POST" 
         } 
      }'
  -H "Content-Type: application/json" -H "Authorization: Bearer <System Access Token>"
 ' 
```

!!! abstract "FI Endpoint Retrieve"

```mermaid
sequenceDiagram

participant Bank Admin User
participant ABC API GW
participant FI SVC
activate Bank Admin User
Bank Admin User ->> ABC API GW: Get Endpoint Details
activate ABC API GW
ABC API GW ->> ABC API GW: Validate Token
activate FI SVC
ABC API GW -->> FI SVC: Get Endpoint 
FI SVC ->> FI SVC Store: Get Endpoint 
FI SVC Store -->> FI SVC: Endpoint
FI SVC -->> ABC API GW: EndPoint 
ABC API GW -->> Bank Admin User: EndPoint 
deactivate ABC API GW
deactivate Bank Admin User
```

##FI Metadata
ABC has a set of Entities which does not exactly match to the similiar entities on the Data Provider.
Matadata is a translation information between ABC and Data Provider. The Dataprovider as part of their
onboadring to the FDP platform should add this translation.This is self serve.

!!! abstract "Create Meta for FI"

```mermaid
sequenceDiagram

participant Bank Admin User
participant ABC API GW
participant FI SVC
activate Bank Admin User
Bank Admin User ->> ABC API GW: Metadata FI
activate ABC API GW
ABC API GW ->> ABC API GW: Validate Token
activate FI SVC
ABC API GW -->> FI SVC: Create Metadata For Entity
FI SVC -->> FI SVC: Validate Payload
FI SVC ->> FI SVC Store: Save Metadata
FI SVC Store -->> FI SVC: MetadataID
FI SVC -->> ABC API GW: Metadata Response
ABC API GW -->> Bank Admin User: Metadata Created Response
deactivate ABC API GW
deactivate Bank Admin User
```

!!! abstract "Example Create FI"
```
curl  -XPOST http://localhost:8060/fi-service/fi/3/metadata 
-d '{ 
      "fiID" : 3 , 
      "objectType" : "Transaction" , 
      "fields" : {
          "type" : "type", 
          "transactionDate" : "transactionDate" , 
          "id" : "id" , 
          "accountID": "accountID", 
          "bankID" : "bankID"
      } 
    }' 
  -H "Content-Type: application/json" -H "Authorization: Bearer <System Access Token>"
```


## Swagger Docs

http://localhost:8060/fi-service/swagger-ui.html

## Storage Diagram


## Class Diagram

!!! abstract "Account Metadata"

```mermaid
classDiagram

IntegrationType o-- FinancialInstitute
EndPointType o-- EndPoint
AuthType o-- FinancialInstitute
IntegrationType o-- EndPoint
ServiceDef o-- EndPoint

AuthType : PASSWORD
AuthType : OAUTH

IntegrationType : API
IntegrationType : PROVIDED
IntegrationType : OFX
IntegrationType : WEB

EndPointType : LINK
EndPointType : UNLINK
EndPointType : TRANSACTION
EndPointType : STATEMENT
EndPointType : TAX_STATEMENT

FinancialInstitute : long id
FinancialInstitute : string name
FinancialInstitute : string address
FinancialInstitute : IntegrationType intMethod
FinancialInstitute : AuthType authType


EndPoints --* FinancialInstitute
EndPoints --* EndPoint

EndPoints : long id
EndPoints : string name
EndPoints : string desc	
EndPoints : string desc
EndPoints : long fiID
EndPoints : EndPoint[] endpoint

EndPoint : long id
EndPoint : EndPointType endPointType
EndPoint : IntegrationType integrationType
EndPoint : ServiceDef serviceDef

ServiceDef : long id
ServiceDef : string url
ServiceDef : string method
ServiceDef : string contentType
ServiceDef : Error[] errors

ProviderServiceDef --|> ServiceDef
OfxServiceDef --|> ServiceDef
WebServiceDef --|> ServiceDef
ApiServiceDef --|> ServiceDef

```


