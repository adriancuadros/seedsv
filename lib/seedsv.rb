if defined?(Rails) && Rails::VERSION::MAJOR == 3
  require 'seedsv/csv_seed'
  require 'seedsv/engine'
end