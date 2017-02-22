class AddColumnToJobOffer < ActiveRecord::Migration[5.0]
  def change
    add_column :job_offers, :tfidf, :jsonb
  end
end
