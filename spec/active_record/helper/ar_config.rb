path = File.dirname(__FILE__) + '/../db/database.yml'
dbfile = File.open(path)
dbconfig = YAML::load(dbfile)
ActiveRecord::Base.establish_connection(dbconfig)
ActiveRecord::Base.logger = Logger.new(STDERR)
DatabaseCleaner.strategy = :truncation

def migration_folder name
  migrations_path = File.dirname(__FILE__)
  name ? File.join("#{migrations_path}" "#{name}") : "#{migrations_path}/migrations" # adding /migrations here is safer
end

def migrate name = nil
  mig_folder = migration_folder(name)

  puts "Migrating folder:" << mig_folder

  ActiveRecord::Migrator.migrate mig_folder
end
