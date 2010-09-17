include CsvSeed

namespace :db do
  namespace :seed do
    desc 'Seeds your database with csv files under db/csv/*'
    task :csv => :environment do
      Dir.foreach(Rails.root + 'db/csv') do |file|
        unless File.directory?(file)
          seed_model(file.singularize, file)
        end
      end
    end
  end
end