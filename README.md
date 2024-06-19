# Introduction
This project implements a class that manages event subscriptions and broadcasts for handlers. Users can subscribe or unsubscribe to specific event handlers and broadcast events to those subscriptions.

# Usage
Clone this repository and run the following command:
```
bundle install
```
To run the test suite:
```
bundle exec rspec
```
To check for linting and code formating inconsistencies, `rubocop` is used:
```
# To check for errors
rubocop

# To autocorrect all correctable errors
rubocop -a
```

**This project has a `test.rb` file which includes a real life example of how this project could work. You can run it through this command:**
```
ruby test.rb
```
