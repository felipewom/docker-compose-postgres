# Docker-Compose with PostgreSQL ready to use

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/felipewom)

This tutorial teaches you how to create a Postgres Docker Compose file.

>Last updated March 13, 2022 </br>
Time to read 3m

## Context

### Why using Docker Compose to a create Postgres database

PostgreSQL is one of the most used database engines nowadays. If you're here today, it's because you probably need it in your project!

When I'm working on a new project, I like to have a clean environment. One of the things I dislike the most is installing "big" tools on my computers (for example, a database engine).

I like to use containers for some of my tools. I'm not going to lie, I'm not constantly moving all my environments to Docker, but I like to have a part of it in a dedicated one.

One command is enough to set up a Postgres database in Docker from scratch with new parameters. With one command, you can also shut down all the environment and free your computer from work.

## Create a Postgres Docker Compose

In this part, I will show you how to create a Postgres Docker Compose example. The configuration file will be detailed line per line, so you will be able to test it and configure it for your needs.

### Step 1. Create the Docker Compose file

The first step consists of creating the configuration file to run Postgres in Docker.

This file is called docker-compose.yml, and you can make it at your project's root. If you don't have any project yet, you can do it in a new folder on your computer.

Once you created the Docker Compose file, your folder architecture should be similar as below.
```
    .
    ├── [...]
    └── docker-compose.yml
    [...] directories, 1 file
```

### Step 2. Configure your Postgres Docker Compose file

To reach your goal of creating a Postgres Docker Compose file, we will use the [image for PostgreSQL](https://hub.docker.com/_/postgres) available on Docker Hub.
This image will simplify the job by providing all the dependencies to run Postgres in Docker.

The main two steps of the configuration will be:

1. import the Postgres image in the Docker Compose
2. configure the database to fit your needs and use it on your computer

Below, you will find the Docker Compose file. Each line is commented on so that you can understand the purpose of each instruction.
  
**Database Service:**

```yaml
# A Docker Compose must always start with the version tag.
# We use '3' because it's the last version.
version: '3'

# You should know that Docker Compose works with services.
# 1 service = 1 container.
# For example, a service, a server, a client, a database...
# We use the keyword 'services' to start to create services.
services:
  # The name of our service is "database"
  # but you can use the name of your choice.
  # Note: This may change the commands you are going to use a little bit.
  database:
    # Official Postgres image from DockerHub (we use the last version)
    image: 'postgres:latest'

    # By default, a Postgres database is running on the 5432 port.
    # If we want to access the database from our computer (outside the container),
    # we must share the port with our computer's port.
    # The syntax is [port we want on our machine]:[port we want to retrieve in the container]
    # Note: You are free to change your computer's port,
    # but take into consideration that it will change the way
    # you are connecting to your database.
    ports:
      - 5432:5432

    environment:
      POSTGRES_USER: username # The PostgreSQL user (useful to connect to the database)
      POSTGRES_PASSWORD: password # The PostgreSQL password (useful to connect to the database)
      POSTGRES_DB: default_database # The PostgreSQL default database (automatically created at first launch)
```

With this first version of your Postgres Docker Compose file, you will be able to run the database and connect to it!

### Step 2. Postgres Docker Compose configurations file (_optional_)

Before running your file, I want to share with you some optional configurations. These steps are not mandatory, and to keep the Postgres Docker Compose example simple, we will not use them at the tutorial end.

Set-up an environment file for your Postgres database
If you don't want to put your environment variable in your Docker Compose file, you can create an environment file at your project root. This file should be named .env, and it should be located at the root of your repository with your Docker Compose.

    .
    ├── [...]
    ├── .env
    └── docker-compose.yml
    [...] directories, 1 file

As I explained in the Postgres Docker Compose comments, the environment variables are defined in the environment part of the configuration. If you copy/paste the environment variables from the Docker Compose file to your .env file, you will have the following:

```env
POSTGRES_USER=username
POSTGRES_PASSWORD=password
```

Once you did it, it means your environment part isn't used anymore so that you can remove it.

#### REMOVE THESE LINES FROM `docker-compose.yml`

```yaml
environment:
    POSTGRES_USER=username # The PostgreSQL user (useful to connect to the database)
    POSTGRES_PASSWORD=password # The PostgreSQL password (useful to connect to the database)
```

If you want that your Postgres Docker Compose find the environment variables, you should add the following lines:

### The `env_file` tag allows us to declare an environment file

```yaml
env_file:
    - .env # The name of your environment file (the one at the repository root)
```

Your Docker Compose will use the environment variables defined inside the .env to configure the database.

### Use a volume to persist data on your computer

By default, the Postgres data will be only in the container. If you decide to delete the container, all the data are going to disappear definitively.

To persist the data, we will use a Docker volume. It will share the database date inside of your container with a local folder of your computer. It means that everytime you will re-build your Postgres Docker Compose, these same data will be used for the current project.

To do that, you can add the database section in the services node of your Docker Compose.

```yaml
# The `volumes` tag allows us to share a folder with our container
# Its syntax is as follows: [folder path on our machine]:[folder path to retrieve in the container]
volumes:
    # In this example, we share the folder `db-data` in our root repository, with the default PostgreSQL data path
    # It means that every time the repository is modifying the data inside
    # of `/var/lib/postgresql/data/`, automatically the change will appear in `db-data`
    # You don't need to create the `db-data` folder. Docker Compose will do it for you
    - ./db-data/:/var/lib/postgresql/data/
```

### Use a volume to add a postgres initialization script

It is also possible to add an init script that will execute when the database is first run. Again, we can use a volume
for this.

```yaml
volumes:
    # In this example, we share an init.sql script with the container
    # The init script will be executed when the database is first run
    - ./init.sql:/docker-entrypoint-initdb.d/init.sql

```

### Step 3. Run the Docker Compose

Your Docker Compose is ready! 🚀

In the root of your project repository, type the following command to install the dependencies and run your database:

```shell
docker-compose up
```

That's it; everything is set up! To test your database, you should connect to it using the software or programming language of your choice.

As a reminder, the Postgres database is accessible on localhost with the port 5432. You can find the connection information (the username, the password, and the default database).

### Step 4. Stop the Docker Compose

As I mentioned before, one of the advantages of using Docker Compose for Postgres is to avoid background processes on your computer. When you finish working on your project, I recommend you to stop the running Postgres Docker container using the command below:

```shell
docker-compose down
```

Once you want to work again on your project, you can use docker-compose up again to run your database.

## Author

- **Felipe Moura** - [felipewom](https://github.com/felipewom)
