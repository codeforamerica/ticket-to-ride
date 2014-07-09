class RemoveLanguagesFromContactPeople < ActiveRecord::Migration
  def change
    remove_column :contact_people, :home_language, :string
    remove_column :contact_people, :guardian_language, :string
    remove_column :contact_people, :had_english_instruction, :boolean
  end
end
