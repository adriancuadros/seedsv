namespace :db do
  namespace :seed do
    include CsvSeed
    desc 'Seeds your database with csv files under db/csv/*'
    task :csv => :environment do
      Dir.foreach(Rails.root + 'db/csv') do |file|
        unless File.directory?(file)
          seed_model(eval(file.split('.').first.classify))
        end
      end
    end
    
    desc "Cleans up the database if you messed up your seed"
    task :cleanup => :environment do
      Dir.foreach(Rails.root + 'db/csv') do |file|
        unless File.directory?(file)
          eval(file.split('.').first.classify).destroy_all
        end
      end
    end
    
  end
end