class JobOffersController < ApplicationController

  before_action :set_job_offer, only: [:show, :edit, :update, :destroy]
  before_action :set_company, only: [:index, :new, :create]

  def index
    @job_offers = JobOffer.all
    @job_offers = policy_scope(JobOffer)
  end


  def show
  end

  def new
    @job_offer = JobOffer.new
    authorize @job_offer
  end

  def create
    @job_offer = JobOffer.new(job_offer_params)
    authorize @job_offer
    @job_offer.user = current_user
    @job_offer.tfidf = conversion(@job_offer)
    if @job_offer.save
        redirect_to  "/companies/#{@company.id}/candidates#job_offer_#{@job_offer.id}"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @job_offer.user = current_user
    @job_offer.update(job_offer_params)
    redirect_to company_path(current_user.company, anchor: "job_offers")
  end

  def destroy
    @company = @job_offer.user.company
    @job_offer.contacted_candidates.destroy_all
    @job_offer.delete
    redirect_to company_path(current_user.company, anchor: "job_offers")
    # redirect_to "/companies/#{@company.id}#job_offers"
  end

private

  def set_job_offer
    @job_offer = JobOffer.find(params[:id])
    authorize @job_offer
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def job_offer_params
    params.require(:job_offer).permit(:title, :document, :user)
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

  def script_hacker
    JobOffer.all.each do |job_offer|
      unless job_offer.document.nil?
        job_offer.tfidf = conversion(job_offer)
        job_offer.save
      end
    end

  end
end
