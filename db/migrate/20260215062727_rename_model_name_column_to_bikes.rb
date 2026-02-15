class RenameModelNameColumnToBikes < ActiveRecord::Migration[6.1]
  def change
    rename_column :bikes, :model_name, :name
  end
end
