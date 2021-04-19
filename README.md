# myQuest Backend
This is the Ruby on Rails API backend of myQuest !

![](https://cdn.discordapp.com/attachments/584465372489449608/833542286419689472/Webp.net-resizeimage_4.png) [Find us on discord](https://discord.gg/uh6FudeY9Q)

# Installation

## Prerecquisites
* Install [Docker](https://docs.docker.com/install/)
* Install [Docker Compose](https://docs.docker.com/compose/install/)

## Install & Initialize :
This installation instructions assumes that you have already installed the prerecquisites above.


1. Run `docker-compose build` to build the ruby image.
2. Run `docker-compose run --rm web bundle install` to install dependencies.
3. Download the environment variables file `.env` and follow the instructions from our discord server at  `MYQUEST-BACKEND -> #ressources -> Setup environment vars`.
4. Run `docker-compose run --rm web rake db:create db:migrate RAILS_ENV=development` to setup the database.
5. Follow the instructions from our discord server at `MYQUEST-BACKEND -> #ressources -> Setup PgAdmin`.


If you do not want to use docker, you can still use a regular installation of rails in your system, in that case :
- Check #Version section below that you have the right versions installed on your system, if not, install them.
- Skip 1. 2. and do the 3.
- Make your `config/database.yml`.
- Run the 4. without docker.
- Feel free to install PgAdmin or any db GUI
  
# Project
URL : `localhost:3000`.
PgAdmin : `localhost:8080`.

Run the project with `docker-compose up` will start every containers.

Run `docker-compose up <container name>` to run single container with its depending containers.

Stop and remove container with `docker-compose down`.

Since the project is powered by docker compose, you'll run command into containers via `docker-compose exec/run <container name> command`.

For more informations about containers you should take a look to `docker-compose.yml`.

You can change the port of containers if they are already in use on your system. Open `docker-compose.yml`, find `ports` definition and change for example : `<the_port_you_want>:3000`. Then you can access them from your computer throught the port you chose.
/!\ do not push these changes in a commit please /!\

## Options
You can add the following options after `docker-compose up` :

* background
`-d` to execute containers in background.

* scale container
`--scale web=<n>` with n = number of web container you want to run.

* close container after command execution
add `--rm` after the container name.

## Available Commands
Run bundle install after adding gem `docker-compose run web bundle install`.

Open rails console with `docker-compose run web rails c`.

Open a bash in a container `docker-compose exec <container_name> bash`

Create database `docker-compose run web rake db:create`.

Migrate database `docker-compose run web rake db:migrate`.

Delete database `docker-compose run web rake db:drop`.

Restore database `cat <dump_path> | docker exec -i db psql -U <database_user> -Fc <database_name>`.

## Troubleshooting
Since we use docker here, depending on your system the files may have docker as owner. In that case then when you'll want to modify them you'll may get an permission error. Run `sudo chown "$USER":"$USER" . -R` at the root of the project and will be good.

When you'll add a new gem, make sur to rebuild the docker container (explained above) before run `bundle install`.

If you get a database error, verify on wich environment you are by setting the correct environment `docker-compose run web rails db:environment:set RAILS_ENV=<environment_name>`.

## Version
This project was bootstrapped with [Ruby on Rails](https://rubyonrails.org/) and powered by [Docker](https://www.docker.com/) and Docker compose.

- Ruby (ruby 3.0.0) running on buster
- Rails 6.1.3.1, default port : 3000
- Postgres (13.2) Port : 5432
- PgAdmin 5.1