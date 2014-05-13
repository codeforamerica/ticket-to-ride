class CreateWelcomeMessages < ActiveRecord::Migration
  def change
    create_table :welcome_messages do |t|
        t.string :message, null: false
        t.string :language

        t.belongs_to :school
    end
  end
end
