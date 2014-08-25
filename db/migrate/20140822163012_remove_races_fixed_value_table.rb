class RemoveRacesFixedValueTable < ActiveRecord::Migration
  def change
    drop_table :races
  end
end
