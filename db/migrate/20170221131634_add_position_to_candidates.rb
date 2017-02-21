class AddPositionToCandidates < ActiveRecord::Migration[5.0]
  def change
    add_column :candidates, :position, :string
  end
end
