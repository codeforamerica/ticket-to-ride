class CreateClerks < ActiveRecord::Migration
  def change
    create_table :clerks do |t|
      t.string :name
      t.timestamps
    end
  end
end
