class RemoveContactedFromMatches < ActiveRecord::Migration[5.0]
  def change
    remove_column :matches, :contacted, :boolean
  end
end
