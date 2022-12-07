# micro-geocoder

Geocoder microservice.

## Dependencies
- Ruby 3.1.0

## Installation
```
bundle install
```

## HTTP
### To run the app
```
bin/http
```
The app is running by default at `http://localhost:3000`.

To change the port edit file `config/settings.yml`.

### Endpoints
```
POST http://localhost:3000/v1/coordinates

PARAMS
{
  city: 'Москва'
}

RESPONSE
200 OK
{
  "latitude": 55.7540471,
  "longitude": 37.620405
}

OR

404 Not Found
{
  "error": "Cannot locate 'Paris'"
}

OR

422 Unprocessable Entity
{
  "errors": [
    {
      "city": "Invalid city"
    }
  ]
}
```
## RPC
### To run the app
```
bin/rpc
```

## To run tests
```
bundle exec rspec
```
