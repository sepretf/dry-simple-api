# REST SIMPLE AUTH API DRY 

This is a authentification REST API.

Using: PostgreSQL, Dry-RB, JSonapi-serializer

Thought and designed to be tested with RSPEC in ./spec/

Code architecture rules for this project were:
  - Limit logic in controller
  - Forms to create object
  - Validators to check data received 
  - Queries to fetch data
  - Data serializer
  - Use services for logic
  - Easy to test and to stub data
  
## Install

    bundle install
    bundle exec rake db:create 
    bundle exec rake db:migrate 

## Run the app

    bundle exec rails s

## Run the tests

    bundle exec rspec .

# REST API

The REST API to the example app is described below.

## Get list of Things

## Create a new User

### Request

`POST /api/v1/users`

    curl -i -H 'Accept: application/json' -d 'email=foo@bar.co&first_name=Foo&last_name=Bar&password='TestPassword' http://localhost:3000/api/v1/users

### Response

    HTTP/1.1 201 Created
    Date: Thu, 24 Feb 2011 12:36:30 GMT
    Status: 201 Created
    Connection: close
    Content-Type: application/json
    Location: /thing/1

 {"data"=>
  {"id".        => "#{user_id}",
   "type".      => "user",
   "attributes" => {
     "id"         => "#{user_id}",
     "first_name" => "Foo",
     "last_name"  => "Bar",
     "email"      => "foo@bar.co",
     "token"      => "#{user_token}"
   }
 }
 }

## Login with a User

### Request

`POST /api/v1/users/login`

    curl -i -H 'Accept: application/json' -d 'email=foo@bar.co&password='TestPassword' http://localhost:3000/api/v1/users/login

### Response

    HTTP/1.1 201 Created
    Date: Thu, 24 Feb 2011 12:36:30 GMT
    Status: 201 Created
    Connection: close
    Content-Type: application/json
    Location: /thing/1

 {"data"=>
  {"id".        => "#{user_id}",
   "type".      => "user",
   "attributes" => {
     "id"         => "#{user_id}",
     "first_name" => "Foo",
     "last_name"  => "Bar",
     "email"      => "foo@bar.co",
     "token"      => "#{user_token}"
   }
 }
 }
 
## Auto Login with from token in header

### Request

`GET /api/v1/users/login/auto_login`

    curl -H 'Accept: application/json' -H "Authorization: Bearer ${TOKEN}" http://localhost:3000/api/v1/users/login/auto_login

### Response

    HTTP/1.1 201 Created
    Date: Thu, 24 Feb 2011 12:36:30 GMT
    Status: 201 Created
    Connection: close
    Content-Type: application/json
    Location: /thing/1

 {"data"=>
  {"id".        => "#{user_id}",
   "type".      => "user",
   "attributes" => {
     "id"         => "#{user_id}",
     "first_name" => "Foo",
     "last_name"  => "Bar",
     "email"      => "foo@bar.co",
     "token"      => "#{user_token}"
   }
 }
 }
