# Development setup

* Install postgres: `brew install postgresql`
* Create the database: `createdb ksr-jobs-scraper-development`
* Install dependencies: `bundle install`
* Run migrations: `bundle exec ruby migrate.rb`
* Define a `.env` file using `.env.sample` as an example

Then run the app

* `bundle exec ruby app.rb`

### Debugging in console

* Make sure you have the latest version of `pry` installed
  * `gem install pry`
  * `gem install pry-rescue`
  * `gem install pry-byebug`
* Open the console `pry -I . -r app.rb`

### Deploying

* `git push heroku master`