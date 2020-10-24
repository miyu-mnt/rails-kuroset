class RenameUsersBioColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :users_bio, :user_bio
  end
end