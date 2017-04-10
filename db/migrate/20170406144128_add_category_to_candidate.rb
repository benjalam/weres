class AddCategoryToCandidate < ActiveRecord::Migration[5.0]
  def change
    add_column :candidates, :category, :string
  end
end
