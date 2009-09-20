class GamesController < ApplicationController
  def show
    @game = Game.new
  end
end