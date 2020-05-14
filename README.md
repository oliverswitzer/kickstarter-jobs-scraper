# Tl;dr

This project is a scraper that will post to Slack whenever new jobs are posted or removed from the [Kickstarter jobs page](https://www.kickstarter.com/jobs). We run the scraper on a daily basis in Heroku. 

The idea is to give employees who were laid off from Kickstarter in May 2020 who have [recall rights](https://en.wikipedia.org/wiki/Right_of_recall) a way to stay informed on what job positions have been posted.

# New to the codebase?

The main flow is delineated in `core/uses_cases/scrape_and_post_changes.rb`. This will be the most informative file to look 
at to grep what this app is doing.

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

### Running migrations

For right now, it is necessary to run migrations manually when you deploy to heroku. 

To do this:

1. Ensure you've added your migration to `persistence/migrate.rb`
1. Push to heroku `git push heroku master`
1. Run `heroku run "bundle exec ruby persistence/migrate.rb""`
