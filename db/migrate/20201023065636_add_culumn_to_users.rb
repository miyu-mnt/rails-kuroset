class AddCulumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :users_bio, :string
  end
end
