require './config/environment.rb'

class CreateUsers < ActiveRecord::Migration
    def change 
      create_table :users do |t|
        t.string :name  
        t.string :email
        t.string :password_digest
        t.integer :user_id
      end
    end
  end