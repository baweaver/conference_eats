class GatheringsController < ApplicationController
  def index
    @gatherings = Gathering.all
  end

  def show
    @gathering = Gathering
      .includes(:gathering_outings)
      .find(params[:id])
  end

  def create
    render status: 404
  end

  def new
    render status: 404
  end

  def update
    render status: 404
  end

  def edit
    render status: 404
  end

  def destroy
    render status: 404
  end
end
