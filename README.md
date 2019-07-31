# Whether-Sweater

Welcome to Whether-Sweater, a RESTful JSON API designed to expose endpoints to display weather for different cities, create and login users, and find forecast for future road trip which to be consumed by a hypothetical front end. It consumes the Dark Sky API for gathering weather data, parses it and returns only what is expected in the project specifications. Location data is parsed from a user friendly city, address, or location by Google Cloud Service's Geocoding API into latitude and longitude.

## Intent
This project was completed in 7 days as a requirement for Module 3.

The project was built using Ruby on Rails which implements the following:

- Object oriented programming principles
- Building an Internal API app
- External API calls to Google Geocoding and DarkSky

## Tech Stack
- Rails 5.2.3
- Ruby 2.4.1
- PostgreSQL

## Available Endpoints:

```
GET /api/v1/forecast?location=denver,co
Headers:
Content-Type: application/json
Accept: application/json
```

```
GET /api/v1/backgrounds?location=denver,co
Headers:
Content-Type: application/json
Accept: application/json
```

```
POST /api/v1/users
   Headers:
    Content-Type: application/json
    Accept: application/json

   Body:
    {
      "email": "my_email@example.com",
      "password": "password"
      "password_confirmation": "password"
    }
```

```
POST /api/v1/sessions
   Headers:
    Content-Type: application/json
    Accept: application/json

   Body:
    {
      "email": "my_email@example.com",
      "password": "password"
    }
```

```
POST /api/v1/road_trip
Content-Type: application/json
Accept: application/json

body:

{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```

## Production Site
Not secure at the moment, message me for link
