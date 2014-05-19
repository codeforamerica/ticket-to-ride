class MakeSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|

      # School's contact information
      t.string :mailing_street_address_1, null: false
      t.string :mailing_street_address_2, null: false
      t.string :mailing_zip_code, null: false
      t.string :phone, null: false
    end
  end
end