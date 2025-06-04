class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.integer :form_user_id, null: false #誰が
      t.integer :to_user_id, null: false #誰に

      t.timestamps
    end
  end
end
