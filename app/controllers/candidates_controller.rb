class CandidatesController < ApplicationController
  skip_after_action :verify_authorized, only: :matching

  def index
    @company = Company.find(params[:company_id])
    @candidates = policy_scope(Candidate)
    authorize @company
  end

  def show
    authorize @candidate
    @company = Company.find(params[:company_id])
    @job_offer = JobOffer.find(params[:job_offer_id])
    @candidate = Candidate.find(params[:id])
  end

  def new
    @candidate = Candidate.new
    authorize @candidate
    @candidate.build_job_offer
  end

  def create
      @candidate = Candidate.new(candidate_params)
      @candidate.job_offer.user = current_user
      @candidate.job_offer.tfidf = conversion(@candidate.job_offer)
      @candidate.user = current_user
      authorize @candidate
      if @candidate.save
        redirect_to company_path(@candidate.user.company, anchor: "uploaded_cvs")
      else
        render :new
      end
    end


  def destroy
    @candidate = Candidate.find(params[:id])
    authorize @candidate
    @candidate.delete
  end

  def upvote
    @candidate = Candidate.find(params[:id])
    authorize @candidate
    @job_offer = JobOffer.find(params[:job_offer_id])

    if @job_offer.voted_for? @candidate
       @job_offer.unvote_for @candidate
    else
      @job_offer.up_votes @candidate
    end
  end

  def matching
    @company = Company.find(params[:company_id])
    @candidates = policy_scope(Candidate)
    @job_offers = {}
    @company.job_offers.each do |job_offer|
      @job_offers[job_offer] = Matching.new.matching(job_offer) if job_offer.candidates == []
    end
    render layout: false
  end

  private

  def candidate_params
    params.require(:candidate).permit(:name, :position, :document, :email, :job_offer_attributes => [:document, :title])
  end


  def conversion(offer)
    stopwords = ["the","be","to", "of", "and","a", "in", "that", "have", "I", "it",
                  "for", "not", "on", "with", "he", "as", "you", "do", "at",
                  "this", "but", "his", "by", "from", "they", "we", "say", "her",
                  "she", "or", "an", "will", "my", "one", "all", "would", "there",
                  "their", "what", "so", "up", "out", "if", "about", "who", "get",
                  "which", "go", "me", "when", "make", "can", "like", "time", "no",
                  "just", "him", "know", "take", "person", "into", "year", "your",
                  "good", "some", "could", "them", "other", "than", "then", "now",
                  "look", "only", "come", "its", "over", "think", "also", "back",
                  "after", "use", "two", "how", "our", "work", "first", "well",
                  "way", "even", "new", "want", "because", "any", "these", "give",
                  "day", "most", "us", "le", "de", "un", "être", "et", "à", "il",
                  "avoir", "ne", "je", "son", "que", "se", "qui", "ce", "dans",
                  "en", "du", "elle", "au", "de", "ce", "le", "pour", "pas", "que",
                  "vous", "par", "sur", "faire", "plus", "dire", "me", "on", "mon",
                  "lui", "nous", "comme", "mais", "pouvoir", "avec", "tout", "y",
                  "aller", "voir", "en", "bien", "où", "sans", "tu", "ou", "leur",
                  "si", "deux", "mari", "moi", "vouloir", "te", "venir", "quand",
                  "grand", "celui", "si", "notre", "là", "prendre",
                  "même", "votre", "tout", "rien", "petit", "encore", "aussi",
                  "quelque", "dont", "tout", "trouver", "donner", "temps", "ça",
                  "peu", "même", "falloir", "sous", "parler", "alors",
                  "chose", "ton", "mettre"]
    stopwords_cap = []
    stopwords.each do |word|
      stopwords_cap << word.capitalize
    end
    stopwords += stopwords_cap
    yomu = Yomu.new offer.document.fullpath
    offer = TfIdfSimilarity::Document.new(yomu.text)
    offer_array = offer.text.split(' ')
    offer_array.each do |word|
      if (stopwords.include?(word)) || (word.size < 4)
        offer_array.delete(word)
      end
    end
    new_doc = { text: offer_array.join(" "),
                term_counts: offer.term_counts,
                size: offer.size
              }
  end
end
