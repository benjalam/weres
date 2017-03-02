class Company < ApplicationRecord
  validates :name, presence: true
  has_many :company_companies, dependent: :destroy
  has_many :black_listed_companies, through: :company_companies
  has_many :users, dependent: :destroy
  has_many :candidates, through: :users, dependent: :nullify
  has_many :job_offers, through: :users, dependent: :nullify
  has_many :contacted_candidates, dependent: :nullify
  acts_as_voter

  def companies_who_blacklisted_me
    CompanyCompany.where(black_listed_company: self)
  end

  def not_black_listed_companies
    companies = Company.all
    black_listed_companies = self.black_listed_companies

    if (companies - black_listed_companies) == []
      []
    else
      companies - black_listed_companies - [self]
    end
  end
end
