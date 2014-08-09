# Deploying to Heroku

This guide assumes that you have a Heroku account and have the Heroku Toolbelt installed. These instructions are to be performed via the terminal or command prompt.

## Login to Heroku

Login to your Heroku account. 

```
$ heroku login
```

## Create/Load Your SSH Keys

If you've already configured your Heroku keys with your account. You can skip this step if you've done this with other Heroku apps or it did this during the login (it would say `Uploading SSH public key...`).

If you need to do this, follow [Heroku's documentation](https://devcenter.heroku.com/articles/keys) on this.

## Create the Heroku Instance

This will create a a Heroku app at a specified name (if the name is left off, Heroku will generate one for you). 

```
$ heroku create <name>
```

## Set Environment Variables

First is to tell Rails to run with the `production` environment settings. (<name> is whatever you used to create the Heroku instance).

```
$ heroku config:set RAILS_ENV=production -a <name>
```

Then secret key needs to be set to secure sessions.

```
$ heroku config:set SECRET_KEY_BASE=<key> -a <name>
``` 

## Deploy App via Git

First, check your Git configuration and make sure that `[remote "heroku"]` has the correct app name.

The below command will bring up the configuration.

```
$ git config -e
```

Then check to make sure that the name part is correct.

```
[remote "heroku"]
	url = git@heroku.com:<name>.git
	fetch = +refs/heads/*:refs/remotes/heroku/*
```

(Chances are, this will open in the VI text editor. Pressing `i` will enable you to edit the text. When done editing, press `ESC` and type `:wq` to save changes.)

Next, push your changes to the server.

```
$ git push heroku <branch_name>:master
```

`<branch_name>` only needs to be specified if your local branch is not `master`.


## Load the Database

The database must be created and seeded.

```
$ heroku run rake db:migrate
$ heroku run rake db:seed
```

## Start the Server Process

This loads at least one instance of the web server (i.e. one Heroku dynamo)

```
$ heroku ps:scale web=1
```

From here, you should be able to see the app!

```
$ heroku open
```

## Upgrading

To update the code on Heroku, you'll just need to push the code and update the database.

```
$ git push heroku <branch_name>:master
$ heroku run rake db:migrate
```

TODO: Add instructions on updating if there are `seed.rb` changes.

