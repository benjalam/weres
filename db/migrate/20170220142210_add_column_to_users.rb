class AddColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :company_admin, :boolean
    add_reference :users, :company, foreign_key: true
  end
end
