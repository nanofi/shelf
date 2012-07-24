class PlacesController < ApplicationController
  def index
    @places = Place.all
  end
  def show
    @place = Place.find(params[:id])
  end
  def create
    @place = Place.new(params[:place])
    unless @place.save
      false
    end
  end
  def destroy
    @place = Place.find(params[:id])
    unless @place.destroy
      false
    end
  end
end
