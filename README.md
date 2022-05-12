# Initial Process
    $ rails new cat-tinder-backend -d postgresql -T
    $ cd cat-tinder-backend
    $ rails db:create
    $ bundle add rspec-rails
    $ rails generate rspec:install
    Add the remote from your GitHub classroom repository
    Create a default branch (main)
    Make an initial commit to the repository
    $ rails server
# Cat Resources
    $ rails generate resource Cat name:string age:integer enjoys:text image:text
    $ rails db:migrate
# Initial Check
    $ rspec spec
# Rails Seed
    rails db:seed
# Gem File
    gem 'rack-cors', :require => 'rack/cors'