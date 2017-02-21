class Company < ApplicationRecord
  validates :name, presence: true
  has_many :black_listed_companies, through: :company_companies
  has_many :users
  has_many :candidates, through: :users
  has_many :matches



  def companies_who_blacklisted_me
    CompanyCompany.where(black_listed_company: self)
  end
end
