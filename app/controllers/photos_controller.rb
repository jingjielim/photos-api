# frozen_string_literal: true

class PhotosController < OpenReadController
  include Pagy::Backend
  before_action :set_photo, only: %i[update destroy]

  # GET /photos
  def index
    pagy, records = pagy(Photo.all.reverse_order)

    render json: records, meta: {
      current_page: pagy.page,
      next_page: pagy.next,
      prev_page: pagy.prev,
      total_pages: pagy.pages,
      total_count: pagy.count
    }
  end

  # GET /photos/1
  def show
    render json: Photo.find(params[:id])
  end

  # POST /photos
  def create
    @photo = current_user.photos.build(photo_params)

    if @photo.save
      render json: @photo, status: :created, location: @photo
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /photos/1
  def update
    if @photo.update(photo_params)
      render json: @photo
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /photos/1
  def destroy
    @photo.destroy

    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_photo
    @photo = current_user.photos.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def photo_params
    params.require(:photo).permit(:site, :description)
  end
end
