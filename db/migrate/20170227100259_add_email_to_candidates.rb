class AddEmailToCandidates < ActiveRecord::Migration[5.0]
  def change
    add_column :candidates, :email, :string
  end
end
