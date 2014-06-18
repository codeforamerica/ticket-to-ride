class CreateCustomRequirements < ActiveRecord::Migration
  def change
    create_table :custom_requirements do |t|
      t.string :name
      t.string :description
      t.string :uri
      t.integer :type
      t.integer :district_id
      t.integer :authority_level


      t.timestamps
    end
  end
end
