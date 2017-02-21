class JobOffer < ApplicationRecord
  belongs_to :user
  has_many :candidates, dependent: :nullify
  validates :title, presence: true
  has_many :contacted_candidates, dependent: :destroy
end
