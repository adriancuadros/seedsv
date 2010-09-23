module Seedsv
  # The CSV seed module contains all the logic inside the rake tasks
  module CsvSeed
  
    mattr_accessor :csv_class
  
    #Use appropriate ruby library
    if VERSION.include?('1.9')
      require 'csv'
      @@csv_class = CSV
    else
      require 'fastercsv'
      @@csv_class = FasterCSV
    end
  
    # Receives the reference to the model class to seed.
    # Seeds only when there are no records in the table
    # or if the +force+ option is set to true.
    # Also optionally it can receive the +file_name+ to use.
    def seed_model(model_class, options={})
      if model_class.count == 0 or options[:force]
        table_name = options[:file_name] || model_class.table_name
        puts "Seeding #{model_class.to_s.pluralize}..."
        csv_file = @@csv_class.open(Rails.root + "db/csv/#{table_name}.csv", :headers => true)
        seed_from_csv(model_class, csv_file)
      end
    end
  
    private
  
    # Receives the class reference and csv file and creates all thre records
    # inside one transaction
    def seed_from_csv(migration_class, csv_file)
      migration_class.transaction do
        csv_file.each do |line_values|
          record = migration_class.new
          line_values.to_hash.keys.map{|attribute| record.send("#{attribute.strip}=",line_values[attribute].strip) rescue nil}
          record.save(:validate => false)
        end
      end
    end
  
    # Enforces utf8 as the encoding
    def utf8(string)
      string.force_encoding('utf-8') unless string.nil?
    end
  
  end
end