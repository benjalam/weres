class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.references :company, foreign_key: true
      t.references :job_offer, foreign_key: true
      t.references :candidate, foreign_key: true
      t.boolean :contacted

      t.timestamps
    end
  end
end
