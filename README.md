# Desrcription

*This project was made to understand and practice the structure of an API developed using Ruby on Rails.*

The project is using the gem [active_model_serializers](https://github.com/rails-api/active_model_serializers/) adapting protocols to comply with the specifications of [jsonapi.org](https://jsonapi.org/).

## Dependencies

Ruby version 2.6.3

Rails version 6.0.3

## Geting started

To configure the enviroment run de comand:
```shell
rails db:create db:migrate db:seed
```
and the script will drop the database if it has already been created, create the database, run migrations and populate tables


## Runing tests
To configure the test enviroment run de comand:
```shell
rails db:migrate RAILS_ENV=test
```
And run the tests with:
```shel
rspec
```
