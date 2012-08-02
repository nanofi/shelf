class EntitiesController < ApplicationController
  def create
    @entity = Entity.new(params[:entity])

    unless @entity.save
      false
    end
  end
  def update
    @entity = Entity.find(params[:id])
    @destroy = params[:entity][:place_id].blank?
    if @destroy
      unless @entity.destroy
        false
      end
    else
      @entity.attributes = params[:entity]
      unless @entity.save
        false
      end
    end
  end
end
