require 'csv'

namespace :import do
  desc "import csv file for Rhode Island school database"
  task :csv_leas  => :environment do
    csv_lea_path = Rails.root.join("datasets", "RIDE_leas.csv")
    CSV.foreach(csv_lea_path, :headers => true) do |row|
      Lea.create!(row.to_hash)
    end
  end
end

namespace :import do
  desc "import csv file for Rhode Island school database"
  task :csv_schools  => :environment do
    csv_school_path = Rails.root.join("datasets", "RIDE_schools.csv")
    CSV.foreach(csv_school_path, :headers => true) do |row|
      School.create!(row.to_hash)
    end
  end
end

task :all => [:csv_leas, :csv_schools] do
  puts "Import all"
end