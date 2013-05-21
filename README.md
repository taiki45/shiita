# Shiita *ʃiːtə* [![Build Status](https://travis-ci.org/taiki45/shiita.png?branch=master)](https://travis-ci.org/taiki45/shiita)
Shiita is open source [Qiita](http://qiita.com/) clone, especially for private gourps such as enterprise.

## Why Shiita?
Qiita is fantastic service for most of us. Besides, Qiita started [Qiita:Team](https://teams.qiita.com/) for private uses.

But we are good to have a choice, which is fee-free and of course open-source.
We can try private Qiita like service easily. If the service brings much good to you, you can start Qiita:Team.

## Features
- Authentication with google account
- Github flavored markdown
- Syntax highlighting (Supporting syntaxes depends on [CodeRay](http://coderay.rubychan.de/))
- Tag following
- User following
- Stocks like Qiita
- Comments in each Article
- UI with Ajax
- Tag limitation system with suggestion
- Example conf files for working with nginx + unicorn via https

### Not yet
- json-based RESTful API
- Full text search

### Maybe
- Client app as Mac app
- LaTeX, MathML, and AsciiMath supports using [MathJax](https://github.com/mathjax/MathJax/)

## Requirements
- Ruby >= 1.9.3 (only MRI support)
- MongoDB

## Setup for development
* Set ENV variables. `env_sample.sh` is sample.
* See more detail to get API key in [omniauth-google-oauth2](https://github.com/zquestz/omniauth-google-oauth2).
* Run `rake db:mongoid:create_indexes` to create indexed on DB.

## Setup for production
* Ensure your server user can sudo without confirming password (necessary for Capistrano).
* Install rbenv.
* Install MongoDB.
* Install nginx and set `nginx.conf` referring `nginx.conf.example`.
* Setup certificates for your server.
* Ensure set ENV vars referring `env_sample.sh` and `config/deploy.rb`, `config/unicorn.conf`.
* run `cap:deploy:check` on local machine to check necessaries.
* run `cap deploy:setup` on local machine.
* run `cap deploy` on local machine.
