class Candidate < ApplicationRecord
  belongs_to :user
  belongs_to :job_offer
  validates :name, presence: true
  has_many :contacted_candidates, dependent: :destroy
  has_attachment :document
  acts_as_votable
end
