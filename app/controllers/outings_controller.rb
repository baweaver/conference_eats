class OutingsController < ApplicationController
  before_action :set_gathering
  before_action :set_outing, only: %i[ show edit update destroy ]

  # GET /outings or /outings.json
  def index
    @outings = @gathering.outings
  end

  # GET /outings/1 or /outings/1.json
  def show
  end

  # GET /outings/new
  def new
    @outing = @gathering.outings.build
  end

  # GET /outings/1/edit
  def edit
  end

  # POST /outings or /outings.json
  def create
    @outing = @gathering.outings.build(outing_params)

    respond_to do |format|
      if @outing.save
        format.html { redirect_to gathering_outing_url(@outing), notice: "Gathering outing was successfully created." }
        format.json { render :show, status: :created, location: @outing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @outing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /outings/1 or /outings/1.json
  def update
    respond_to do |format|
      if @outing.update(outing_params)
        format.html { redirect_to gathering_outing_url(@outing), notice: "Gathering outing was successfully updated." }
        format.json { render :show, status: :ok, location: @outing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @outing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outings/1 or /outings/1.json
  def destroy
    @outing.destroy

    respond_to do |format|
      format.html { redirect_to gathering_outings_url, notice: "Gathering outing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_outing
      @outing = @gathering.outings.find(params[:id])
    end

    def set_gathering
      @gathering = Gathering.find(params[:gathering_id])
    end

    # Only allow a list of trusted parameters through.
    def outing_params
      params.fetch(:outing, {})
    end
end
