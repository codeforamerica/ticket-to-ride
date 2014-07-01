class CreateLea < ActiveRecord::Migration
  def change
    create_table :leas do |t|
      t.string :lea_name
      t.integer :lea_code
    end
  end
end
