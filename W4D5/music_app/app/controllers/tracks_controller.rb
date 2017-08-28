class TracksController < ApplicationController

  def index
    @tracks = Track.all
    render :index
  end

end
