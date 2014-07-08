class AddLanguagesToStudents < ActiveRecord::Migration
  def change
    remove_column :students, :second_language, :string
    add_column :students, :home_language, :string
    add_column :students, :guardian_language, :string
    add_column :students, :had_english_instruction, :boolean
  end
end
