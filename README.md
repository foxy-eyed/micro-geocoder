# micro-geocoder

Geocoder microservice.

## Dependencies
- Ruby 3.1.0

## Installation
```
bundle install
```

## To run the app
```
bin/app
```
The app is running by default at `http://localhost:3000`.

To change the port edit file `config/settings.yml`.

## Endpoints
```
POST http://localhost:3000/v1/

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

### To run tests
```
bundle exec rspec
```
