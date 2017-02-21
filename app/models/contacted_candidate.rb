class ContactedCandidate < ApplicationRecord
  belongs_to :company
  belongs_to :job_offer
  belongs_to :candidate
end
