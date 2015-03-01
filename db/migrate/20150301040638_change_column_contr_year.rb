class ChangeColumnContrYear < ActiveRecord::Migration
  def change
    change_column :movies, :year, :string, null: true
  end
end
