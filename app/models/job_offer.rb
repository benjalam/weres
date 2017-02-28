class JobOffer < ApplicationRecord
  belongs_to :user
  has_many :candidates, dependent: :destroy
  validates :title, presence: true
  has_many :contacted_candidates, dependent: :destroy
  has_attachment :document
  acts_as_voter


  def candidate_contacted?(candidate)
    contacted_candidates.where(candidate: candidate).exists?
  end

  def to_tfidf
    TfIdfSimilarity::Document.new(tfidf["text"], term_counts: tfidf["term_counts"], size: tfidf["size"])
  end
end
