Ticket to RIDE
==============

Code Island's in-progress app for school enrollment in Rhode Island

Running this application
------------------------------

Create a `config/secrets.yml` with following content:

```ruby+yaml
# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure the secrets in this file are kept private
# if you're sharing your code publicly.

development:
  secret_key_base: e105766f95ec57071674fb01eabd2107a0e64a6783dae8ad26b0517635b6265e9818c6db4225d3b87ce1aeece9f95faaa38b9b1588a2989edc539617502a4f46

test:
  secret_key_base: 5e14526a80c74a3d5e286c8254d2bea6f68fa79e57c67b325a6b490f61a7d09c3359d7f646c1608c77e00333224d05f7ee13d60e2bac11147f7b2b5604c1f927

# Do not keep production secrets in the repository,
# instead read values from the environment.
production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
```

You could generate a new `secret_key_base` via `rake secret`.

### Create the database

```bash
$ rake db:create
```

### Run all migrations

```bash
$ rake db:migrate
```

### Start the server

```bash
$ rails s
```

Your server will be up at http://127.0.0.1:3000.

