class SpicesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  #GET/spices
  def index
    spices = Spice.all
    render json: spices       
  end

  #POST/Spices
  def create
    spice = Spice.create(spice_params)
    render json: spice, status: :created
  end
 # GET/spice by id

 def show 
  spice =find_spice
  render json: spice
  end

  # PATCH /spices/:id
  def update
    spice = find_spice
    spice.update(spice_params)
    render json: spice
  end

  # PATCH /spices/:id/like
  def increment_likes
    spice = find_spice
    spice.update(likes: spice.likes + 1)
    render json: spice
  end

  # DELETE /spices/:id
  def destroy
    spice=find_spice
    spice.destroy
    head :no_content
  end

  private
  
  def find_spice
    Spice.find(params [:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Spice not found" }, status: :not_found
  end
 
  def spice_params
    params.permit(:title, :image, :description,:notes, :rating)
  end

end