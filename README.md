# SURVEY CHALLENGE API REST

## HOW TO RUN
Initially there will need to install the appropriate version of ruby with asdf

```
$ asdf install
```

### Local settings

In local, you must include some environment variables (Consult the developer), related to authentication.


### Install gems, database and migrations

```
$ bundle install
$ bundle exec rake db:create
$ bundle exec rake db:migrate
```

### Start the project

```
rails s -p 3001
```

and Survey Challenge API Rest should be available at [localhost:3001](http://localhost:3001)

## ENDPOINTS

### PUT /products

Removes all stored products and creates the new products sent in the request's body.

### POST /interests

Creates a new interest related to a previously stored product and a user

### GET /categories

You can get a limited number of product's categories, ordered by the average of the user scores.

### GET /products

You can get a limited number of products, ordered by the average of the user scores.