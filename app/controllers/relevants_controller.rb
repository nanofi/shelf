class RelevantsController < ApplicationController
  def create
    @relevant = Relevant.new(params[:relevant])

    unless @relevant.save
      false
    end
  end
  def destroy
    @relevant = Relevant.find(params[:id])
    unless @relevant.destroy
      false
    end
  end
end
