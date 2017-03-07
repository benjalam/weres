class ContactController < ApplicationController
  def new

  end

  def create
  end

  private

  def candidate_params
    params.require(:candidate).permit(:name, :position, :document, :email)
  end
end
