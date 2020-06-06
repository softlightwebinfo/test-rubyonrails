# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Create project and database config
- rails new appname -d=postgresql
- echo 'export APPNAME_DATABASE_PASSWORD="PostgreSQL_Role_Password"' >> ~/.bash_profile
- source ~/.bash_profile
- nano config/database.yml

####
    default: &default
      adapter: postgresql
      encoding: unicode
      # For details on connection pooling, see Rails configuration guide
      # http://guides.rubyonrails.org/configuring.html#database-pooling
      pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
      username: appname
      password: <%= ENV['APPNAME_DATABASE_PASSWORD'] %>
    
    development:
      <<: *default
      database: appname_development
    ...
    
- rails db:create
- rails g model user
####
    /app 
    ├── /app  
    ├── /bin
    ├── /config
    ├── /db
        ├── /migrate
            ├── 20191227230259_create_postres.rb 
####
    class CreateUsers < ActiveRecord::Migration[6.0]
      def change
        create_table :users do |t|
    
          t.string :name
          t.string :email
          t.string :password
          t.string :phone
    
          t.timestamps
          t.column :deleted_at, :datetime, :limit => 6
        end
      end
    end

- rake db:migrate
- rails server --binding=127.0.0.1
- http://127.0.0.1:3000

## Create controllers and views
- rails g controller users index read create update 

