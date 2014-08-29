# Developer Setup for Windows

This is a guide for setting up Ruby and Rails on Windows, such that Ticket to RIDE can be run.
Note: The [JRuby instructions](developer_jruby_setup.md) are preferable to these since compatibility is much more reliable.

# NodeJS

A JavaScript runtime is needed for Rails and NodeJS is a good, free, and widely used one.

1. Download and install [NodeJS](http://nodejs.org/)

# Ruby and Rails

1. Download and install [Ruby 1.9.3](http://rubyinstaller.org/downloads) (make sure to choose the option to update the `PATH` variable)
1. Download the [Ruby 1.9.3 Development Kit](http://rubyinstaller.org/downloads)
1. Extract the Development kit to `C:\RubyDevKit193`
1. Open a Command Prompt
1. `cd C:\RubyDevKit193`
1. `ruby dk.rb init`
1. `ruby dk.rb install`
1. `gem install rails`

# Ticket to RIDE

From here, follow the [developer setup](developer_setup.md).