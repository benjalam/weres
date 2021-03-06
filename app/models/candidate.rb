class Candidate < ApplicationRecord
  belongs_to :user
  belongs_to :job_offer
  accepts_nested_attributes_for :job_offer
  validates :name, presence: true
  has_many :contacted_candidates, dependent: :nullify
  has_attachment :document, accept: [:pdf]
  acts_as_votable

end
