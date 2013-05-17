# Shiita [![Build Status](https://travis-ci.org/taiki45/shiita.png?branch=master)](https://travis-ci.org/taiki45/shiita)
Shiita is open source [Qiita](http://qiita.com/) clone, especially for private gourps such as enterprise.

## Why Shiita?
Qiita is fantastic service for most of us. Besides, Qiita started [Qiita:Team](https://teams.qiita.com/) for private uses.

But we are good to have a choice, which is fee-free and of course open-source.
We can try private Qiita like service easily. If the service brings much good to you, you can start Qiita:Team.

## Features
- Authentication with google account
- Github flavored markdown
- Syntax highlighting (Supporting syntaxes depends on [Coderay](http://coderay.rubychan.de/))
- Tag following
- User following
- Stocks like Qiita
- Comments in each Article
- UI with Ajax

### Not yet
- UI with Pjax
- Tag limitation system with suggestion
- json-based API
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

## License
Copyright (c) 2013 Taiki ONO

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
