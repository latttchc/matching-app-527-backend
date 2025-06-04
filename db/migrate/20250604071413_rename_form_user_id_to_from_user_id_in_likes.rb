class RenameFormUserIdToFromUserIdInLikes < ActiveRecord::Migration[8.0]
  def change
    rename_column :likes, :form_user_id, :from_user_id
    # The `from_user_id` column now represents the user who liked the form.
    # The `to_user_id` column remains unchanged and represents the user whose form was liked.
  end
end
