class TypesController < ApplicationController
  before_action :set_type, only: [:show]

  # GET /types
  # GET /types.json
  def index
    @types = Type.all
  end

  # GET /types/1
  # GET /types/1.json
  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_type
    @type = Type.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def type_params
    params.require(:type).permit(
      :name
    )
  end
end
