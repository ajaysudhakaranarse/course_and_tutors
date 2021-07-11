# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  2.5

* Rails version
  5.1.7

* Database
  sqlite3

* Database initialization: rails db:create, rails db:migrate, rails db:seed

* How to run the test suite: rspec

* API information

1. Login
  url: http://{URL}/login
  method: get
  response: { token: '' }

2. Courses
  - Create
    url: http://{URL}/courses
    method: post
    headers: {'Content-Type': 'application/json', 'Authorization': token}
    params:
      { "course":
        { "name": "mca",
          "tutors_attributes":
            [
              { "name": "test", "mobile": "9812121213"}
            ]
        }
      }

  - Index
    url: http://{URL}/courses
    method: get
