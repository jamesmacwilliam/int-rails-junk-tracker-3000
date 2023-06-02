class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[ show edit update destroy ]
  before_action :set_ivars, except: %i[update destroy create]

  # GET /vehicles or /vehicles.json
  def index; end

  # GET /vehicles/1 or /vehicles/1.json
  def show
  end

  # GET /vehicles/new
  def new
    @vehicle = Vehicle.new
  end

  # GET /vehicles/1/edit
  def edit
  end

  # POST /vehicles or /vehicles.json
  def create
    @vehicle = Vehicle.new(vehicle_params)

    if @vehicle.save
      render json: @vehicle, status: :ok
    else
      render json: @vehicle.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /vehicles/1 or /vehicles/1.json
  def update
    if @vehicle.update(vehicle_params)
      render json: @vehicle, status: :ok
    else
      render json: @vehicle.errors, status: :unprocessable_entity
    end
  end

  # DELETE /vehicles/1 or /vehicles/1.json
  def destroy
    @vehicle.destroy

    render json: @vehicle, status: :ok
  end

  private

  def set_ivars
    @vehicles = Vehicle.order(:nickname)
    @vehicle_types = VehicleType.order(:name)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def vehicle_params
    params.require(:vehicle).permit(:nickname, :headline, :is_stacked, :vehicle_type_id)
  end
end
