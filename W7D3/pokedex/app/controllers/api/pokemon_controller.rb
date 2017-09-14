class Api::PokemonController < ApplicationController

  def index
    @pokemon = Pokemon.all
    render
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    render
  end


end
