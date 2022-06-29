class ToysController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_not_found_message
rescue_from ActiveRecord::RecordInvalid, with: :invalid_updated_post
  wrap_parameters format: []

  def index
    toys = Toy.all
    render json: toys
  end

  def create
    toy = Toy.create!(toy_params)
    render json: toy, status: :created
  end

  def update
    toy = get_toy
    toy.update!(toy_params)
    render json: toy  
  end

  def destroy
    toy = get_toy
    toy.destroy
    head :no_content
  end

  private

  def get_toy
    toy = Toy.find(params[:id])
  end

  def render_not_found_message
    render json: { error: "Toy not found! Try again" }, status: :not_found
  end
  
  def toy_params
    params.permit(:name, :image, :likes)
  end

end
