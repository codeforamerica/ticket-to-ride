class DropLeas < ActiveRecord::Migration
  def up
    drop_table :leas
  end

  def down
    create_table :leas do |t|
      t.string :lea_name
      t.integer :lea_code
    end
  end
end
