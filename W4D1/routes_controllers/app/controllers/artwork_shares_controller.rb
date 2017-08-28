class ArtworkSharesController < ApplicationController
  def create
    artwork_share = ArtworkShare.new(artwork_share_params)
    if artwork_share.save!
      render json: artwork_share
    else
      render json: ArtworkShare.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @artwork_share = ArtworkShare.find(params[:id])
    @artwork_share.destroy
    render json: @artwork_share
  end

  def index
    @artwork_shares = ArtworkShare.all
    if @artwork_shares
      render json: @artwork_shares
    else
      render json: ArtworkShare.errors.full_messages, status: 404
    end
  end

  private
  def artwork_share_params
    params[:artwork_share].permit(:artwork_id,:viewer_id)
  end
end
