class Match < ApplicationRecord
  belongs_to :company, dependent: :destroy
  belongs_to :job_offer, dependent: :destroy
  belongs_to :candidate, dependent: :destroy
end
