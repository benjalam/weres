class Matching
require 'matrix'
  def matching(offer)
    start = Time.now
    # 1) Find last uploaded offer (TFIDF from database)
    offer_tfidf = offer.to_tfidf


    #2) Select all offers with CV associated => start_corpus
    corpus = []
    job_offers = JobOffer.all
    # job_offers =  JobOffer.includes(:candidates).joins(:document_files).all
    job_offers.each do |job_offer|
      unless job_offer.document.nil?
        unless offer.user.company == job_offer.user.company.company_companies

       corpus << {offer: job_offer, tfidf: job_offer.to_tfidf}
        end
      end
    end
    @corpus = corpus.map {|c| c[:tfidf]}


    #3) Add our offer to start_corpus => corpus completed
    @corpus << offer_tfidf
    print_time(start, 'SET CORPUS')

    # 4) Build model + matrix
    model = TfIdfSimilarity::TfIdfModel.new(@corpus)
    matrix = model.similarity_matrix
    print_time(start, 'SET MODEL')
    #5 Iterate to get scores
    @scores = []
    corpus.each do |job_offer|
      if job_offer[:offer].user.company.black_listed_companies.where(name: offer.user.company.name).empty?
            @scores << { job_offer: job_offer[:offer],
                         score: norme(matrix[model.document_index(job_offer[:tfidf]), model.document_index(offer_tfidf)])
                       }
      end
    end
    print_time(start, 'SCORE')
    @scores = @scores.sort_by {|hash| hash[:score]}
    print_time(start, 'SORT SCORE')
    return @scores
  end

  def print_time(start, step)
    puts " TIME FOR #{step} ==> #{Time.now - start}"
  end

  def norme(score)
    if score > 0.3
      return 0.99
    else
     return (score / Math.exp(1-score))*(Math.exp(1-0.5)/0.3)
   end
  end

end
