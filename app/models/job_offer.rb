class JobOffer < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  has_many :matches
  has_attachment :document
end
