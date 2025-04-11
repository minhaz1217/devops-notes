```
@baseUrl = localhost:8080
@oauthBaseUrl = localhost:27019
 
### Get auth token
# @name getToken
POST /realms/quarkus/protocol/openid-connect/token HTTP/1.1
Host: {{oauthBaseUrl}}
Content-Type: application/x-www-form-urlencoded

username=alice&password=alice&grant_type=password&client_id=backend-service&client_secret=secret

### ServiceProvider - Create
# @name createServiceProvider
@accessToken = {{getToken.response.body.$.access_token}}
POST /api/v1/service-provider HTTP/1.1
Host: {{baseUrl}}
accept: application/json
Content-Type: application/json
Authorization: Bearer {{accessToken}}
Content-Length: 639

{
    "name": "Test_Name_{{$guid}}",
    "caseId": "4e632e9f-5848-4b09-b1d6-fb9faf3b53b9",
    "subItemId": "ea631bd9-0ed0-47ea-9436-0f4926e22e7a",
    "uid": "Test_Uid_{{$guid}}",
    "address": {
            "street": "Reggie Summit",
            "no": "89207 Schmidt Run",
            "zip": "a5:07:4e:67:c9:7f",
            "city": "East Antonettaberg",
            "contact": {
                    "name": "Rafael Windler",
                    "phone": "751-975-6353",
                    "mail": "Louisa_Russel@gmail.com"
                }
        },
    "tradeIds": [
        "9e015425-5fcb-4b1d-9f4e-e4896cf27fe9"
    ]
}



### ServiceProvider - Search
# @name searchServiceProvider
@accessToken = {{getToken.response.body.$.access_token}}
@serviceProviderId = {{createServiceProvider.response.body.$.id}}
POST /api/v1/service-provider/search HTTP/1.1
Host: {{baseUrl}}
accept: application/json
Content-Type: application/json
Authorization: Bearer {{accessToken}}
Content-Length: 74

{
  "serviceProviderId": "{{serviceProviderId}}"
}

### ConnectedCase - Create Trade
# @name createConnectedCaseTrade
@accessToken = {{getToken.response.body.$.access_token}}
@serviceProviderId = {{createServiceProvider.response.body.$.id}}
@addressId = {{searchServiceProvider.response.body.$.[0].addresses.[0].id}}
@contactId = {{searchServiceProvider.response.body.$.[0].addresses.[0].contacts.[0].id}}
POST /api/v1/connected-cases/repair HTTP/1.1
Host: {{baseUrl}}
accept: application/json
Content-Type: application/json
Authorization: Bearer {{accessToken}}
Content-Length: 290

{
  "serviceProviderId": "{{serviceProviderId}}",
  "addressId": "{{addressId}}",
  "contactId": "{{contactId}}",
  "repairId": "{{$guid}}",
  "affectedTradeId": "{{$guid}}"
}

### ConnectedCase - Search
# @name searchConnectedCase
@accessToken = {{getToken.response.body.$.access_token}}
POST /api/v1/connected-cases/search HTTP/1.1
Host: {{baseUrl}}
accept: application/json
Content-Type: application/json
Authorization: Bearer {{accessToken}}
Content-Length: 114

{
    "serviceType": "REPAIR"
}
```