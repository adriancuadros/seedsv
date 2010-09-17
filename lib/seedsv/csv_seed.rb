module CsvSeed
  
  #Use appropriate ruby library
  if VERSION.include?('1.9')
    require 'csv'
    csv_class = CSV
  else
    require 'fastercsv'
    csv_class = FasterCSV
  end
  
  def seed_from_csv(migration_class, csv_file)
    migration_class.transaction do
      csv_file.each do |line_values|
        record = migration_class.new
        line_values.to_hash.keys.map{|attribute| record.send("#{attribute.strip}=",line_values[attribute]) }
        record.save(:validate => false)
      end
    end
  end
  
  def utf8(string)
    string.force_encoding('utf-8') unless string.nil?
  end
  
  def seed_model(model_class, table_name=nil)
    if model_class.count == 0
      table_name||= model_class.table_name
      puts "Seeding #{model_class.to_s.pluralize}..."
      csv_file = csv_class.open(Rails.root + "db/csv/#{table_name}.csv", :headers => true)
      seed_from_csv(model_class, csv_file)
    end
  end
  
end