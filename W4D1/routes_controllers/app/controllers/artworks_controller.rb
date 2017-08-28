class ArtworksController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @artworks_shared = @user.shared_artworks
    @artworks_owned = @user.artworks
    if @artworks_shared && @artworks_owned
      render json: {artworks_shared: @artworks_shared, artworks_owned: @artworks_owned}
    else
      render json: Artwork.errors.full_messages, status: 404
    end
  end

  def create
    artwork = Artwork.new(artwork_params)
    if artwork.save!
      render json: artwork
    else
      render json: Artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @artwork = Artwork.find(params[:id])
    if @artwork
      render json: @artwork
    else
      render json: Artwork.errors.full_messages, status: 404
    end
  end

  def update
    @artwork = Artwork.find(params[:id])
    if @artwork.update(artwork_params) && @artwork.save!
      render json: @artwork
    else
      render json: Artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @artwork = Artwork.find(params[:id])
    @artwork.destroy
    render json: @artwork
  end


  private
  def artwork_params
    params[:artwork].permit(:title, :image_url, :artist_id)
  end
end
