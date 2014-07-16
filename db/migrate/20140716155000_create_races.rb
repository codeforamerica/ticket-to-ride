class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.string :race, null: false

      t.timestamps
    end
  end
end
