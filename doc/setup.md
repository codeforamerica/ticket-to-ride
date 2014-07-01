# Setup

## Clone the project

After cloning the project, open a terminal / command prompt and navigate into the cloned folder.

## Install dependencies

Use the following command:

```
    $ bundle install
```

## Configure the secrets file

The secrets file should be created at `config/secrets.yml`.

A sample file might look like this:

```
development:
 secret_key_base: 18d663515881b44a429fa
production:
 secret_key_base: e937cb8480a410149e793
```

The keys can be generated using the terminal command:

```
    $ rake secret
```

## Database configuration

Add your Postgres database's username and password to the `config/database.yml` file.

## Database setup

```
    $ rake db:create && rake db:migrate
```

## Load CSV

 Load CSV files into your local database. When it's done, you should have 69 Local Education Agencies (LEAs) and over 300 schools:

```
    $ rake import:all
```

## Seed the Database

```
    $ rake db:seed
```

## Start the server

```
    $ rails server
```