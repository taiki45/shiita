# Shiita *ʃiːtə*
[![Build Status](https://travis-ci.org/taiki45/shiita.png?branch=master)](https://travis-ci.org/taiki45/shiita) [![Coverage Status](https://coveralls.io/repos/taiki45/shiita/badge.png)](https://coveralls.io/r/taiki45/shiita)

Shiita is open source [Qiita](http://qiita.com/) clone, especially for private gourps such as enterprise. Shiita encourages your members to record and share technical knowledge, learning, know-how.

## Why Shiita?
Qiita is fantastic service for most of us. Besides, Qiita started [Qiita:Team](https://teams.qiita.com/) for private uses.

But we are good to have a choice, which is fee-free and of course open-source.
We can try private Qiita like service easily. If the service brings much good to you, you can start Qiita:Team.

## Features
- Authentication with google account
- Github flavored markdown
- Syntax highlighting (Supporting syntaxes depends on [CodeRay](http://coderay.rubychan.de/))
- TeX support using [MathJax](https://github.com/mathjax/MathJax/), see more detail at below section
- Tag following
- User following
- Stocks like Qiita
- Comments in each Article
- Tag limitation system with suggestion
- Full text search with index on Japanese and English
- Example configuration files for working with nginx + unicorn via https

### Maybe
- Client app as Mac app

## How to write using TeX?
Shiita extends github flavored markdown a little bit.

You can write with inline style as

```
Inline styel is `$ -b \pm \sqrt{b^2 - 4ac} \over 2a $` .
```

```
Wrap your formulae by `$ and $` .
```

To write with block style, just notice the code block is TeX.

<pre>
```tex
f(a,b) = \int_a^b \frac{1 + x}{a + x^2 + x^3} dx
```
</pre>

## Requirements
- Ruby >= 1.9.3 (only MRI support)
- MongoDB
- [MeCab](https://code.google.com/p/mecab/) and it's ruby-binding

## Setup for development
* Set ENV variables. `env_sample.sh` is sample.
* See more detail to get API key in [omniauth-google-oauth2](https://github.com/zquestz/omniauth-google-oauth2).
* Run `rake db:mongoid:create_indexes` to create indexed on DB.

## Setup for production
* Ensure your server user can sudo without confirming password (necessary for Capistrano).
* Install rbenv.
* Install MongoDB.
* Install MeCab and it's ruby-binding.
* Install nginx and set `nginx.conf` referring `nginx.conf.example`.
* Setup certificates for your server.
* Ensure set ENV vars referring `env_sample.sh` and `config/deploy.rb`, `config/unicorn.conf`.
* run `cap:deploy:check` on local machine to check necessaries.
* run `cap deploy:setup` on local machine.
* run `cap deploy` on local machine.

## License
MIT License. see [LICENSE](LICENSE).
