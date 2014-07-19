class RemoveDefaultSpecialServiceValues < ActiveRecord::Migration
  def change
    change_column_default :students, :iep, nil
    change_column_default :students, :p504, nil
  end
end
