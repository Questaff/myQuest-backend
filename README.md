# Dockerized Ruby on Rails API
This project was bootstrapped with [Ruby on Rails](https://rubyonrails.org/) and powered by [Docker](https://www.docker.com/) and Docker compose. This is the API version of [Dockerized Ruby on Rails](https://github.com/Shirikumo/dockerized-rails).

# Installation

## Prerecquisites
* Install [Docker](https://docs.docker.com/install/)
* Install [Docker Compose](https://docs.docker.com/compose/install/)

## Install & Initialize :
```
docker-compose pull
docker-compose build
docker-compose run --rm web bundle install
(now you should name your db in `/config/database.yml` or the db's name will be 'rails_<env>')
docker-compose run --rm web rake db:create RAILS_ENV=development
docker-compose down
```
# Project
URL : `localhost:3000`

Run the project with `docker-compose up` will open every containers.

Run `docker-compose up <container name>` to run single container with its depending containers.

Stop and remove container with `docker-compose down`.

Since the project is powered by docker compose, you'll run command into containers via `docker-compose exec/run <container name> command`.
For more informations about containers you should take a look to `./docker-compose.yml`

By default database credentials are :
user : `postgres`
password : `pass`

## Options
You can add the following options after `docker-compose up` :

* background
`-d` to execute containers in background.

* scale container
`--scale web=<n>` with n = number of web container you want to run.

## Available Commands
Run bundle install after adding gem `docker-compose run web bundle install`

Open rails console with `docker-compose exec web rails c`

Open a bash in a container `docker-compose run <container_name> bash`

Create database `docker-compose run web rake db:create`

Migrate database `docker-compose run web rake db:migrate`

Delete database `docker-compose run web rake db:drop`

Restore database `cat <dump> | docker exec -i db psql -U <database_user> -Fc <database_name>`

## Troubleshooting
Since we use docker here, depending on your system the files may have docker as owner. In that case then when you'll want to modify them you'll may get an permission error. Run `sudo chown "$USER":"$USER" . -R` at the root of the project and will be good.

When you'll add a new gem, make sur to rebuild the docker container (explained above) before run `bundle install`.

If you get a database error, verify on wich environment you are by setting the correct environment `docker-compose run web rails db:environment:set RAILS_ENV=<environment_name>`.

## Notice
You should take a look at `./config/database.yml` to change database config.

You should make several env files for each environment's credentials and globals.

## Version
- Ruby (ruby 3.0.0) running on buster
- Rails 6.1.3.1, default port : 3000
- Postgres (11.2) Port : 5432
