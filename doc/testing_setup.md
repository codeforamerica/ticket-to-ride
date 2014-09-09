# Setup for Testing

# Test Database Setup

Run the following to create, setup, and populate the database.

```
$ rake db:test:prepare 
```

Any time you use rake db:migrate to make a change to the development database, mirror that change on the test database.

```
$ rake db:test:clone 
```


# Run specs from command line

```
$ rake spec 
```
