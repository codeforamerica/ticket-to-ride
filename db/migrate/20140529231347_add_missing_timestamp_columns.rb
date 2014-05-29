class AddMissingTimestampColumns < ActiveRecord::Migration
  def change
    # contact_people
    add_column :contact_people, :created_at, :datetime
    add_column :contact_people, :updated_at, :datetime

    # districts
    add_column :districts, :created_at, :datetime
    add_column :districts, :updated_at, :datetime

    # guardians
    add_column :guardians, :created_at, :datetime
    add_column :guardians, :updated_at, :datetime

    # schools
    add_column :schools, :created_at, :datetime
    add_column :schools, :updated_at, :datetime

    # students
    add_column :students, :created_at, :datetime
    add_column :students, :updated_at, :datetime

    # welcome messages
    add_column :welcome_messages, :created_at, :datetime
    add_column :welcome_messages, :updated_at, :datetime
  end
end
