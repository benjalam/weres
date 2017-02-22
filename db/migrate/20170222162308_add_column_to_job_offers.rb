class AddColumnToJobOffers < ActiveRecord::Migration[5.0]
  def change
    add_column :job_offers, :document, :string
  end
end
