# Developer Setup for JRuby

This is a guide for setting up Ticket to RIDE with JRuby. This will work on any OS.

# JRuby (UNIX, Mac, Linux)

If you have RVM, issue the following command:

`rvm install jruby`

If not download and install from [JRuby.org](http://jruby.org). Following this, switch to jruby as your Ruby installation.

# JRuby (Windows)

1. Download [JRuby](http://jruby.org).
1. Install JRuby and make sure to check the option that says to configure `PATH`
1. Open a new command prompt and run `jruby -v` to confirm installation

# Rails

From your command prompt, enter the following command:

`gem install rails`

# Note for Windows Users

JRuby 1.7.14 and below currently has a bug where CTRL+C does not actually kill the server on the command prompt (i.e. the port
is still reserved for JRuby/Rails after killing the app). This problem can be gotten around by using an IDE such
as RubyMine to start/stop your Rails server. A [bug fix](https://github.com/jruby/jruby/issues/1115) is 
currently slated for JRuby 1.7.15.

# Ticket to RIDE

From here, follow the [developer setup](developer_setup.md).

# Known Issues

While the application runs smoothly on JRuby, there is a current issue with unit test detection using it. This means that running `rake spec` will detect no unit tests.