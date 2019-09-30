# Customer Onboarding 
Users can onboard to FDP via self signin , this module should also serve the user dashboard service.
User should be able to initiate account lookup and data import export via this service.


## User Signup

!!! abstract "User Signup"

```mermaid
sequenceDiagram

participant User
participant ABC GW
participant Cust SVC
participant Cust SVC Store
participant Auth SVC

activate User
User ->> ABC GW: Signup
activate ABC GW
ABC GW ->> Cust SVC : Signup
activate Cust SVC
Cust SVC -->> Cust SVC : Validate Payload
Cust SVC -->> User : Onboarding Error
Cust SVC ->> Cust SVC Store : Save User
activate Cust SVC Store
Cust SVC Store -->> Cust SVC : User Details
deactivate Cust SVC Store
Cust SVC ->> Auth SVC : User Auto login
activate Auth SVC
Auth SVC -->> Cust SVC : User AT
deactivate Auth SVC
Cust SVC -->> ABC GW : UserProfile + AT
deactivate Cust SVC
ABC GW -->> User : UserProfile + AT
deactivate ABC GW
deactivate User
```
## Update User


!!! abstract "Update User"

```mermaid
sequenceDiagram

participant User
participant ABC GW
participant Auth SVC
participant Cust SVC
participant Cust SVC Store

activate User
User ->> ABC GW: Profile Update
activate ABC GW
ABC GW ->> Auth SVC: Validate Login
activate Auth SVC
Auth SVC -->> ABC GW: Login Status
deactivate Auth SVC
ABC GW ->> Cust SVC : Update User
activate Cust SVC
Cust SVC -->> Cust SVC : Validate Payload
Cust SVC -->> User : Profile Update Error
Cust SVC ->> Cust SVC Store : Save User
activate Cust SVC Store
Cust SVC Store -->> Cust SVC : User Details
deactivate Cust SVC Store
Cust SVC -->> ABC GW : UserProfile
deactivate Cust SVC
ABC GW -->> User : UserProfile
deactivate ABC GW
deactivate User
```
## Retrieve UserProfile
Logged in User will retrieve the user details


!!! abstract "User Profile"

```mermaid
sequenceDiagram

participant User
participant ABC GW
participant Auth SVC
participant Cust SVC
participant Cust SVC Store

activate User
User ->> ABC GW: Get UserProfile
activate ABC GW
ABC GW ->> Auth SVC: Validate Login
activate Auth SVC
Auth SVC -->> ABC GW: Login Status
deactivate Auth SVC
ABC GW ->> Cust SVC : Get UserProfile
activate Cust SVC
Cust SVC -->> Cust SVC : Validate Payload
Cust SVC -->> User : Profile Update Error
Cust SVC ->> Cust SVC Store : Get User
activate Cust SVC Store
Cust SVC Store -->> Cust SVC : User Details
deactivate Cust SVC Store
Cust SVC -->> ABC GW : UserProfile
deactivate Cust SVC
ABC GW -->> User : UserProfile
deactivate ABC GW
deactivate User
```

## User Data Management
User Data Management is about linking the user account in ABC with the other financial data provider.
Its also about triggering new data import into FDP initiated by the user. The facility for linking account, importing data into 
ABC is provided in FI micro service. UserManagement module can be function as user dashboard service which enableds to initiate 
data aggregation for multiple Data Providers.


!!! abstract "User Accounts"

```mermaid
sequenceDiagram

participant User
participant ABC GW
participant Auth SVC
participant Cust SVC
participant Cust SVC Store
participant FI SVC

activate User
User ->> ABC GW: Get User Accounts
activate ABC GW
ABC GW ->> Auth SVC: Validate Login
activate Auth SVC
Auth SVC -->> ABC GW: Login Status
deactivate Auth SVC
ABC GW ->> Cust SVC : Accounts For User
activate Cust SVC
Cust SVC -->> Cust SVC : Validate Payload
Cust SVC -->> User : Profile Update Error
Cust SVC ->> Cust SVC Store : Get User Details
activate Cust SVC Store
Cust SVC Store -->> Cust SVC : User Details
deactivate Cust SVC Store
Cust SVC -->> FI SVC : Get Accounts For User
activate FI SVC
FI SVC -->> Cust SVC : Accounts
deactivate FI SVC
Cust SVC -->> ABC GW : Accounts
deactivate Cust SVC
ABC GW -->> User : Accounts
deactivate ABC GW
deactivate User
```

!!! abstract "User Transactions"

```mermaid
sequenceDiagram

participant User
participant ABC GW
participant Auth SVC
participant Cust SVC
participant Cust SVC Store
participant FI SVC

activate User
User ->> ABC GW: Get User Transactions
activate ABC GW
ABC GW ->> Auth SVC: Validate Login
activate Auth SVC
Auth SVC -->> ABC GW: Login Status
deactivate Auth SVC
ABC GW ->> Cust SVC : Transactions For User
activate Cust SVC
Cust SVC -->> Cust SVC : Validate Payload
Cust SVC -->> User : Profile Update Error
Cust SVC ->> Cust SVC Store : Get User Details
activate Cust SVC Store
Cust SVC Store -->> Cust SVC : User Details
deactivate Cust SVC Store
Cust SVC -->> FI SVC : Get Transactions For User
activate FI SVC
FI SVC -->> Cust SVC : Transactions
deactivate FI SVC
Cust SVC -->> ABC GW : Transactions
deactivate Cust SVC
ABC GW -->> User : Transactions
deactivate ABC GW
deactivate User
```

