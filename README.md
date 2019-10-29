# Widget Orderer 5000™️

The Widget Orderer 5000™️ (*patent pending*) allows users to order certain types of widgets.

## App Overview

There are a few assumptions baked into widget orders:

* The number of widgets ordered must be a whole number, no partial widgets
* Widgets can only be painted red, blue or yellow
* Widgets can only be delivered within 1 week of order creation
* Widgets come in 3 different types: "Widget", "Widget Pro" and "Widget Xtreme"
* Orders will have a unique order ID (this ID cannot be altered and is created upon successful order creation)

App functionality also includes:

* All orders created are saved to the DB (open the console with `rails c` to check it out)
* Order form creation constraints (based on assumptions above)
* Orders can be created, read, updated, and destroyed (CRUD it up)
* Orders cannot have emails inputted after creation
* Confirmation messages are displayed when orders are created, updated, and destroyed
* All orders are listed on the home page in descending order based off order quantity
* Widget types can be listed and viewed separately (these are generated upon application setup, routes are hidden but follow basic REST routes formatting)

Extra Credit Functionality:
* An optional email can be inputted by users which notifies email with order creation details and link to order details page
* Order tracking is in place with order status shown on `/orders` and `/order/:id` views (order details pages)
* Admin can login and update order status

## Things you'll need to start:

* [RubyGems](https://rubygems.org/pages/download)
* ruby 2.6.5 (I recommend using [rbenv](https://github.com/rbenv/rbenv) to configure your local ruby/rails version)
* rails 6.0.0 ([rails gem download](https://rubygems.org/gems/rails/versions/4.2.6))
* yarn 1.13.0 (https://yarnpkg.com/en/) - dependency manager, installed out of habit/future development potential 
* postgresql 11.5 ([download](https://www.postgresql.org/download/), I recommend using the Homebrew download if you have a mac)

## Testing/Additional Applications

[Rspec](https://rspec.info/) is used for all test coverage. To run locally just run `rspec`. All major controller and model functionality is covered in the `spec` directory.

A variety of gems are used to increase app functionality. A list below:

* [simple_form](https://github.com/plataformatec/simple_form) - Simple forms for Rails
* [aasm](https://github.com/aasm/aasm) - State management for Ruby classes
* [rspec-rails](https://github.com/rspec/rspec-rails) - Above
* [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails) - Useful factory management for Rspec
* [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers) - Helpful Rspec matchers
* [letter_opener](https://github.com/ryanb/letter_opener) - View ActiveMailers locally
* [dotenv-rails](https://github.com/bkeepers/dotenv) - Load `.env` variables
* [database_cleaner](https://github.com/DatabaseCleaner/database_cleaner) - Truncate DB during testing to avoid collisions

### To run locally:

Clone down and run the commands below:

* `git clone git@github.com:chastep/widget_orderer.git`
* `cd widget_orderer`
* `bundle install`
* `yarn install --check-files`
* `./bin/rake db:setup`
* In order to get admin functionality to work locally you'll have to create a fresh `.git.development` file where only you know the credentials. I have the template ready for you:
  * `mv .env.template .env.development`
* Update the variables to something only you know (I'm not looking)
* `./bin/rails s`
* Enjoy!

### Heroku
[Heroku Employee Widget Orderer]()

Just open a PR and push if you find something wrong, any feedback would be greatly appreciated!

This project is released under the [MIT Open Source license](LICENSE.md)
