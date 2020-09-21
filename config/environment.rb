ENV['SINATRA_ENV'] ||= "development"
require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])
ENV['SESSION_SECRET']='ee366d5b54d1f2237d2b68fbb7a632961b0f31a08bf9786bb94b1efbaa98434e5f3f8e52ff3d99a4873540bb9e2cc5d3a6300cd5f4d3e134868bf6d4479d12af'
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require './app/controllers/application_controller'
require_all 'app'
