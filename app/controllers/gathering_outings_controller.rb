class GatheringOutingsController < ApplicationController
  before_action :set_gathering
  before_action :set_gathering_outing, only: %i[ show edit update destroy ]

  # GET /gathering_outings or /gathering_outings.json
  def index
    @gathering_outings = @gathering.gathering_outings
  end

  # GET /gathering_outings/1 or /gathering_outings/1.json
  def show
  end

  # GET /gathering_outings/new
  def new
    @gathering_outing = @gathering.gathering_outings.build
  end

  # GET /gathering_outings/1/edit
  def edit
  end

  # POST /gathering_outings or /gathering_outings.json
  def create
    @gathering_outing = @gathering.gathering_outings.build(gathering_outing_params)

    respond_to do |format|
      if @gathering_outing.save
        format.html { redirect_to gathering_gathering_outing_url(@gathering_outing), notice: "Gathering outing was successfully created." }
        format.json { render :show, status: :created, location: @gathering_outing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @gathering_outing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gathering_outings/1 or /gathering_outings/1.json
  def update
    respond_to do |format|
      if @gathering_outing.update(gathering_outing_params)
        format.html { redirect_to gathering_gathering_outing_url(@gathering_outing), notice: "Gathering outing was successfully updated." }
        format.json { render :show, status: :ok, location: @gathering_outing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @gathering_outing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gathering_outings/1 or /gathering_outings/1.json
  def destroy
    @gathering_outing.destroy

    respond_to do |format|
      format.html { redirect_to gathering_gathering_outings_url, notice: "Gathering outing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gathering_outing
      @gathering_outing = @gathering.gathering_outings.find(params[:id])
    end

    def set_gathering
      @gathering = Gathering.find(params[:gathering_id])
    end

    # Only allow a list of trusted parameters through.
    def gathering_outing_params
      params.fetch(:gathering_outing, {})
    end
end
