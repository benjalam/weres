class MatchingJob < ApplicationJob

  queue_as :default
  require 'matrix'

  def perform(offer)
    start = Time.now
    # 1) Find last uploaded offer (TFIDF from database)
    offer_tfidf = offer.to_tfidf


    #2) Select all offers with CV associated => start_corpus
    corpus = []
    job_offers = JobOffer.all
    # job_offers =  JobOffer.includes(:candidates).joins(:document_files).all
    job_offers.each do |job_offer|
      unless job_offer.document.nil?
       corpus << {offer: job_offer, tfidf: job_offer.to_tfidf}
      end
    end
    @corpus = corpus.map {|c| c[:tfidf]}


    #3) Add our offer to start_corpus => corpus completed
    @corpus << offer_tfidf

    # 4) Build model + matrix
    model = TfIdfSimilarity::TfIdfModel.new(@corpus)
    matrix = model.similarity_matrix
    #5 Iterate to get scores
    @scores = []
    corpus.each do |job_offer|
      @scores << { job_offer: job_offer[:offer],
                   score: matrix[model.document_index(job_offer[:tfidf]), model.document_index(offer_tfidf)]
                 }
    end
    @scores = @scores.sort_by {|hash| hash[:score]}

    return @scores

    Pusher.trigger('qpx_updates', 'done', {
      done: true
    })
  end
end
