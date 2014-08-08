# Setup for Developers

## Assumptions

These instructions assume the following:

- You have the environment requirements setup. If you're working from Windows, please perform the steps documented in [Developer Setup for Windows](developer_windows_setup.md).

## Clone the Project

This will download the project from GitHub to your machine.

```
$ git clone https://github.com/codeforamerica/ticket-to-ride.git
```

After that, move into the directory that got copied.

```
$ cd ticket-to-ride
```

## Install Dependencies

Use the following command:

```
$ bundle install --without production
```

# Database Setup

Run the following to create, setup, and populate the database.

```
$ rake db:migrate
$ rake db:seed
```

# Database Reset

If you've been developing and want to clear your database, you can get a clean database by adding a command to the Database setup instructions.

```
$ rake db:drop
$ rake db:migrate
$ rake db:seed
```

## Start the server

```
rails server
```