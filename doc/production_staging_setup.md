# Setup for Production

## Assumptions

These instructions assume  the following:

- You have the environment requirements setup. If you're working from Windows, please perform the steps documented in [Developer Setup for Windows](developer_windows_setup.md).
- You've installed PostgreSQL and know the URL, name, and login credentials for the database that will be used.

If you're planning to deploy to Heroku, please see that [set of instructions](deploy_to_heroku.md).

## Clone the Project

This will download the project from GitHub to your machine.

```
$ git clone https://github.com/codeforamerica/ticket-to-ride.git
```

After that, move into the directory that got copied.

```
$ cd ticket-to-ride
```

## Install dependencies

Use the following command:

```
$ bundle install
```

# Secrets Setup

To keep sessions secure and generate random session IDs, an environment variable must be set.

To generate a secrets key, run the following command:

```
$ rake secret
```

From here, copy the value and use it to set the environment variable "SECRET_KEY_BASE" (how you set this will be dependent on your operating system).

# Database setup

First, open the `ticket-to-ride/config/database.yml` file and go to the production or staging areas, adding in the hostname/URL, username, and password for your PostgreSQL database.

```
production:
  adapter: postgresql
  encoding: utf-8
  database: ticket_to_ride_production
  host: db.codeforantarctica.org
  username: dbchick
  password: evenbetterpassword
```

Run the following to create, setup, and populate the database.

```
$ rake db:create 
$ rake db:migrate
$ rake db:seed
```

## Upgrading

While updating the code for Ticket to RIDE should be as easy as updating the code from Git, the database will also need to be upgraded.

```
$ rake db:migrate
```

## Start the Server

```
rails server -e production
```

TODO: Explain how do this in conjunction with Unicorn and Apache. This isn't a tradition production way of starting a server.