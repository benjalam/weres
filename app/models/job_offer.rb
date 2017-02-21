class JobOffer < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  has_many :matches
end
