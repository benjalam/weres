class RenameMatches < ActiveRecord::Migration[5.0]
  def change
    rename_table :matches, :contacted_candidates
  end
end
