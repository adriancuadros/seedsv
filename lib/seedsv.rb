# SeedSV provides the functionality to seed your database CSV Files
#
# Author:: Adrian Cuadros
# Copyright:: Copyright (c) 2010 Innku
# License:: MIT License (http://www.opensource.org/licenses/mit-license.php)
#
# Seedsv requires the developer to create the folder csv inside Rails.root/db/
#
# In this folder you will place all your csv files with the same name as your
# database tables. The format of the first line of each file is the following:
#
#     column_name_1, column_name_2, column_name_3...
#
# So for example, to seed the model City, you would normally have the file:
# /db/csv/cities.csv
#
# This is the example content of the file
#
#     name, state_id
#     Monterrey, 1
#     Guadalajara, 2
#
# To seed the databse with this file
#     rake db:seed:csv
#
# If something goes wrong and you want to delete everything seeded from csv files:
#     rake db:seed:cleanup
module Seedsv
  if defined?(Rails) && Rails::VERSION::MAJOR == 3
    require 'seedsv/csv_seed'
    require 'seedsv/engine'
  end
end