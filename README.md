# Desrcription

*This project was made to understand and practice the structure of an API developed using Ruby on Rails.*

The project is using the gem [active_model_serializers](https://github.com/rails-api/active_model_serializers/) adapting protocols to comply with the specifications of [jsonapi.org](https://jsonapi.org/).

## Geting started

To configure the enviroment run de comand:
```shell
rails db:create db:migrate db:seed
```
and the script will drop the database if it has already been created, create the database, run migrations and populate tables

## Runing aplication
Just run the comand:

```shell
docker-compose up
```

## Runing tests
Start docker
```shell
  docker-compose run web bash
```
Then configure the test enviroment runing the comand:
```shell
rails db:migrate RAILS_ENV=test
```
And run the tests with:
```shel
rspec
```
