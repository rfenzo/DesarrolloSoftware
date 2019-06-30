# SETUP
## Docker installation
```
sudo snap install docker
sudo snap connect docker:home
sudo addgroup --system docker
sudo adduser $USER docker
newgrp docker
sudo snap enable docker

base=https://github.com/docker/machine/releases/download/v0.16.0 &&
  curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
  sudo install /tmp/docker-machine /usr/local/bin/docker-machine
  
docker-machine create --driver virtualbox default
docker-machine start default
docker-compose build
docker-compose up
```
Create an empty `.env` file on the project folder

# TIPS AND TRICKS
## Some Docker commands
### Display images
`docker image ls`
### Display containers
`docker container ls`
### Build image
`docker-compose build`
### Run project docker
`docker-compose up`
or
`docker-compose up -d` (background)

## Low level inspection of the container database
```
docker exec -it psql_container_id bash
psql -U postgres donatio_development
```

## High level operations of the container database

`docker-compose exec web rake  db:create`

`docker-compose exec web rake  db:migrate`

`docker-compose exec web rake  db:reset`

Sometimes, you won't be able perform a migration, neither do a reset because of current sessions in the database, in that case you can try restarting the container or delete the database sessions:
- Option 1: Restart the container: `docker-compose stop` and then `docker-compose up`
- Option 2: Remove database sessions:
```
docker exec -it psql_container_id bash

psql -U postgres

REVOKE CONNECT ON DATABASE donatio_development FROM public;
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'TARGET_DB';
```

# Deploy
```
git push heroku development2:master
heroku pg:reset DATABASE
heroku run rake db:migrate db:seed
```
