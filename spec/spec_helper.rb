require 'coveralls'
require 'simplecov'

ENV["RAILS_ENV"] ||= 'test'

Coveralls.wear! 'rails'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter
]

SimpleCov.start 'rails'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'database_cleaner'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

Mongoid.identity_map_enabled = false

RSpec.configure do |config|

  config.infer_base_class_for_anonymous_controllers = true

  config.order = "random"

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = "mongoid"
  end

  config.before(:each) do
    DatabaseCleaner.clean
    Mecab::Ext::Parser.stub_chain("parse.surfaces.map.to_a").and_return(["mystring"])
  end

  config.include FactoryGirl::Syntax::Methods

end
