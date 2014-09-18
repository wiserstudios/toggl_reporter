Do Once
===

````
$ heroku create
$ git push heroku master
$ heroku run rake db:migrate
````

Add another user
===
Whoever owns the toggl account for the team, needs to do this with "master: true" instead of "master: false"
Toggl API tokens can be found here: https://www.toggl.com/app/profile

````
$ heroku run console
> User.create name: "Joe Smith", api_token: "<apitoken>", master: false
````

View what your users are doing
===

````
$ heroku open
````