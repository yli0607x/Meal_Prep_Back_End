class Api::V1::FoodsController < ApplicationController
  before_action :find_food, only: [:update, :destroy]
  def index
    @mealtime = Mealtime.find(params[:day_id])
    @foods = @day.foods
    render json: @foods
  end

  # GET /api/v1/parties/:id
  def show
    @food = Food.find(params[:id])
    render json: @food, status: :ok
  end

  # POST /api/v1/parties
  def create
    # @food = Food.create({ name: params[:name],theme: params[:theme] })
    # @food = Food.create(params.require(:food).permit(:name, :theme))
    @food = Food.create(food_params)
    if @food.valid?
      render json: @food, status: :created
    else
      render json: @food.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @food.update(food_params)
    if @food.save
      render json: @food, status: :accepted
    else
      render json: { errors: @food.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    @food.destroy
    render json: {message: "food deleted"}, status: :ok
  end

  private

  def food_params
    params.permit(:name, :calories, :mealtime_id)
  end

  def find_food
    @food = Food.find(params[:id])
  end
end
