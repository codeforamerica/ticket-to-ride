# Environment

This includes software prerequisites for running Ticket to RIDE.

- Ruby 1.9.x or JRuby 1.7.x
- Rails 4.1.x
- Other dependencies included in [Gemfile](../Gemfile) (can be installed via `bundle install`)

# Windows

If you're working from Windows, please perform the steps documented in [Developer Setup for JRuby (recommended)](developer_jruby_setup.md))
or [Developer Setup for Windows](developer_windows_setup.md).

# Staging / Production

It is recommended that PostgreSQL is used in for staging or production environments. SQLite3 is used for development to make it easier and more lightweight for developers to get started, but may not deliver production-level reliability.