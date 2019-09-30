# GOID Architecture
GOID is a token generation service for allowing api access to clients where the token validation happens in a decentralized way.

## GOID Service Overall Design
![Hige Level Design](GOID_design.png)

## Request to Login

In this step, Client makes a request to GOID for an OTP to log in the user.

```mermaid
sequenceDiagram
participant EndUser
participant Client
EndUser-->>Client: Login Screen
Client->>GOID: Request to Login
activate GOID
GOID->>UserOwner: Lookup by Phone
UserOwner->>GOID: User Profile
GOID--xEndUser: OTP over SMS
GOID->>Client: OTP Token
deactivate GOID
```



## Grant Token

In this step, user enters the OTP and the client makes a request to GOID to verify
and get access and refresh tokens.

```mermaid
sequenceDiagram
participant EndUser
participant Client
EndUser-->>Client: Enters OTP
Client->>GOID: Verify OTP + OTP-Token
activate GOID
GOID->>GOID: Create Session
GOID->>Client: Access & Refresh Tokens
deactivate GOID
Note over GOID,Client: Login Complete
```

## Refreshing Tokens

After receiving the tokens, `Access Token` can be used to make API calls to GOJEK
backend services. `Access Token` is valid only for a configured duration and after
the expiry, the `Refresh Token` should be used to renew the `Access Token`. Client
should try a refresh call to GOID when it receives `401 Unauthorized` from Kong.

```mermaid
sequenceDiagram
Client->>Kong: Request with Expired token
activate Kong
Kong-->>Client: 401 Unauthorized
deactivate Kong
Client-->>GOID: Refresh
activate GOID
GOID-->>Client: Renewed Tokens
deactivate GOID
Client->>Kong: Request with new token
```

## GOID Auth Proxy
GOID Auth Proxy is responsible for verifying the access token and scopes from one of
the known headers during an API call. It is deployed with the API Gateway (i.e., Kong)
as a sidecar or as a plugin.


## Token validation and API access

![Toke Validation](api_gw.png)

```mermaid
sequenceDiagram
Client->>Kong: API Request
Kong-->>Auth Proxy: Verify Token
Auth Proxy-->>Kong: Token Verified
Kong->>Backend: Forward Request
Backend->>Kong: API Response
Kong->>Client: API Response
```
