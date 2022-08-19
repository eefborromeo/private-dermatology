# **[Private Dermatology](https://private-dermatology.herokuapp.com/)**

[![private-dermatology.png](https://i.postimg.cc/XYPbQsF6/private-dermatology.png)](https://postimg.cc/sM5q29wT)

An Appointment Management System and E-Commerce website for a dermatology clinic. Patients can use this website to set their appointments and buy dermatology products if they wish to do so. This app feaures **[Paymongo API](https://developers.paymongo.com/reference/getting-started-with-your-api)** to handle Philippine local transactions, **[Google OAuth](https://github.com/zquestz/omniauth-google-oauth2)** for handling Google Omniauth access, and **[Google Calendar API](https://developers.google.com/calendar/api)** to handle Google Calendar Events. Other gems listed below are also utilized to handle frontend and backend integrations.

##### This project is deployed on Heroku and can be accessed by clicking on the title above.
-----------

## Ruby Version

Ruby 3.1.2

## System Dependencies

* Rails 6.1.6
* NodeJS 16.3.0
* Yarn 1.22.18
* PostgreSQL 14.2

## Featured Gems
* gem 'devise'
* gem 'tailwind-css'
* gem 'rspec-rails'
* gem 'faker'
* gem 'dotenv-rails'
* gem "omniauth-rails_csrf_protection"
* gem 'omniauth-google-oauth2'
* gem "simple_calendar", "~> 2.4"
* gem 'image_processing', '~> 1.2'
* gem "aws-sdk-s3", require: false

## Configuration

```
bundle install
yarn install --check-files
bundle binstubs rspec-core (creates executable for rspec)
```

## Database Initialization

```
rails db:create
  or
rails db:setup (to initiate seeds on the database)

rails db:migrate
```

## How to run the Test Suite

```
bin/rspec (courtesy of bundle binstubs rspec-core)
```

## Deployment Instructions

```
heroku login
git push heroku <branch name>
heroku run rails db:migrate
heroku run rails db:seed
```
-----------

Fair Use
