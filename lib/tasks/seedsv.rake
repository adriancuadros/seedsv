namespace :db do
  namespace :seed do
    include Seedsv::CsvSeed
    desc 'Seeds your database with csv files under db/csv/*'
    task :csv => :environment do
      Dir.foreach(Rails.root + 'db/csv') do |file|
        unless File.directory?(file) or File.extname(file) != '.csv'
          begin
            model_class = eval(file.split('.').first.classify)
            seed_model(model_class) if model_class
          rescue
            puts "#{file.split('.').first.classify} class not found, skiping..."
          end
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