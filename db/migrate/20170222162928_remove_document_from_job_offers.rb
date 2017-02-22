class RemoveDocumentFromJobOffers < ActiveRecord::Migration[5.0]
  def change
    remove_column :job_offers, :document, :string
  end
end
