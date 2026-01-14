class CreateGroupPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :group_posts do |t|
      t.integer :user_id
      t.integer :group_id
      t.text :body

      t.timestamps
    end
  end
end
