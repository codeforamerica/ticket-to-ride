class RemoveFormalEnglishFromStudents < ActiveRecord::Migration
    def change
      remove_column :students, :had_english_instruction
    end
end
