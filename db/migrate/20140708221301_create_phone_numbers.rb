class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.string :number
      t.string :extension
      t.string :level
      t.boolean :receives_sms, default: false
    end
  end
end
