class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :ship, :complete, :destroy]
  before_action :check_for_admin, only: [:ship, :complete]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all.includes(:type)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        OrderMailer.create_order(@order.id, @order.email).deliver if @order.email

        format.html { redirect_to @order, notice: "Order ID: #{@order.uuid} was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: "Order ID: #{@order.uuid} was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def ship
    respond_to do |format|
      if @order.may_ship?
        @order.ship!
        format.html { redirect_to @order, notice: "Order ID: #{@order.uuid} was successfully shipped." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { redirect_to @order, notice: "Order cannot be shipped!" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def complete
    respond_to do |format|
      if @order.may_complete?
        @order.complete!
        format.html { redirect_to @order, notice: "Order ID: #{@order.uuid} was successfully completed." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { redirect_to @order, notice: "Order cannot be completed!" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order ID: #{@order.uuid} was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # redirect all malformed urls
  def redirect_to_home
    redirect_to(orders_path)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  def check_for_admin
    redirect_to @order, notice: "Only admins can do that!" unless session[:admin]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(
      :quantity,
      :color,
      :deliver_by,
      :type_id,
      :email
    )
  end
end
