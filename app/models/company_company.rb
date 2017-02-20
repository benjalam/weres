class CompanyCompany < ApplicationRecord
  belongs_to :company, class_name: "Company", foreign_key: :company_id
  belongs_to :black_listed_company, class_name: "Company", foreign_key: :black_listed_company_id
end
