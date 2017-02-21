class Candidate < ApplicationRecord
  belongs_to :user
  belongs_to :job_offer
  validates :name, presence: true
  has_many :matches
end
