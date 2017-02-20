class CreateCompanyCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :company_companies do |t|
      t.belongs_to :company, references: :company
      t.belongs_to :black_listed_company, references: :company

      t.timestamps
    end
  end
end
