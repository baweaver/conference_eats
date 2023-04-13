class OutingsController < ApplicationController
  before_action :set_gathering
  before_action :set_outing, only: %i[ show edit update destroy join ]

  # GET /outings or /outings.json
  def index
    @outings = @gathering.outings
  end

  # GET /outings/1 or /outings/1.json
  def show
    authorize!(@outing)

    @assigned_group = @outing.assigned_group(current_account)
  end

  # GET /outings/new
  # def new
  #   @outing = @gathering.outings.build
  # end

  # GET /outings/1/edit
  def edit
  end

  def join
    authorize!(@outing)

    @group = @outing.assign_to_group(current_account)
    redirect_to gathering_outing_group_url(id: @group.id, gathering_id: @gathering.id)
  end

  # POST /outings or /outings.json
  # def create
  #   @outing = @gathering.outings.build(outing_params)

  #   if @outing.save
  #     redirect_to gathering_outing_url(@outing), notice: "Gathering outing was successfully created."
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /outings/1 or /outings/1.json
  def update
    if @outing.update(outing_params)
      redirect_to gathering_outing_url(@outing), notice: "Gathering outing was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /outings/1 or /outings/1.json
  # def destroy
  #   @outing.destroy

  #   redirect_to gathering_outings_url, notice: "Gathering outing was successfully destroyed."
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_outing
      @outing = @gathering
        .outings
        .includes(:groups)
        .find(params[:outing_id] || params[:id]) # Fix this later. Don't like
    end

    def set_gathering
      @gathering = Gathering.find(params[:gathering_id])
    end

    # Only allow a list of trusted parameters through.
    def outing_params
      params.fetch(:outing, {})
    end
end
