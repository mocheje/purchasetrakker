
namespace :ptrakk do
  desc "Imports a CSV file into an ActiveRecord table"
  task :csv_import, [:filename, :model] => [:environment] do |task,args|
    md = Module.const_get(args[:model])
    puts "running #{task} in #{Rails.env} environment"
    lines = File.new(File.join(Rails.root, "data", args[:filename]), "r").readlines
    header = lines.shift.strip
    keys = header.split(',')
    count = 0
    lines.each do |line|
      params = {}
      values = line.strip.split(',')
      keys.each_with_index do |key,i|
        params[key] = values[i]
      end
      result = md.create(params)
      puts result.as_json
      count += 1
    end
    puts "*************************************************************************************************"
    puts "********************#{count} new records created in #{args[:model]} Model *************************************"
    puts "*************************************************************************************************"
  end

  desc "Delete all data in Model Cannot be used in production"
  task :model_clear, [:model] => [:environment] do |task,args|
    puts Rails.env
    if Rails.env == "production"
      puts "Cannot run this task in Production environment"
      return
    else
      puts "running #{task} in #{Rails.env} environment"
      md = Module.const_get(args[:model])
      result = md.delete_all
      puts "resetting table sequence"
      puts "Ressetting DB AutoIncrement Number "
      begin
        ActiveRecord::Base.connection.execute("ALTER TABLE #{md.table_name} AUTO_INCREMENT = 1") #sql db
      rescue
        puts "trying to reset for mysql database Will find a more convienent way for this"
      end
      begin
        ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = '#{md.table_name}'") #sqlite db
      rescue
        puts "trying to reset for sqlite database Will find a more convienent way for this"
      end
      puts "#{result} records deleted from #{args[:model]} Model"

    end
  end
end

