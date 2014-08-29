# Developer Setup for JRuby

This is a guide for setting up Ticket to RIDE with JRuby.

# NodeJS (Windows and Linux)

A JavaScript runtime is needed for Rails and NodeJS is a good, free, and widely used one.

1. Download and install [NodeJS](http://nodejs.org/)


# Java

We'll be installing JRuby, which is a Ruby distribution that runs out of Java and has really
good cross platform compatibility. But this means you'll need to install Java.

1. Download [Java](http://www.java.com) and take note of the version number attached to the installer. At time of writing, this will either be 7 or 8 with an update number (example: `7u67`).
1. Install it, but take note of the installation directory (probably: `C:\Program Files\Java`)
1. Download the [Java Cryptography Extension (JCE)](http://www.oracle.com/technetwork/java/javase/downloads/index.html) for the version of Java you installed (such as 7 or 8)
1. Extract the JCE ZIP file and follow the README instructions to installing the files
1. Open a new command prompt and run `java -version` to confirm installation


# JRuby

1. Download [JRuby](http://jruby.org). Choose the `exe(x64)` for 64-bit Windows and `exe` for 32-bit Windows
1. Install JRuby and make sure to check the option that says to configure `PATH`
1. Open a new command prompt and run `jruby --version` to confirm installation

# Rails

From your command prompt, enter the following command:

`gem install rails`

# Ticket to RIDE

After cloning the Ticket to RIDE repository, open a command prompt and move into the directory. After
doing that, perform the following commands:

```
> bundle install --without production
> rake db:drop && rake db:migrate
```

You should now be good to go on running the server.

```
> rails server
```