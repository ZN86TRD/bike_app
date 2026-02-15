class CreateBikes < ActiveRecord::Migration[6.1]
  def change
    create_table :bikes do |t|
      t.integer :user_id, null: false
      t.string :maker, null: false
      t.string :model_name, null: false
      t.integer :bike_type, null: false, default: 0
      t.string :component

      t.timestamps
    end
  end
end
