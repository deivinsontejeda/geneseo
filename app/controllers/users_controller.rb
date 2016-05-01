class UsersController < ApplicationController

  def show
    self.current_user = params[:id].to_i
    @game = Game.where("player_#{@current_user}_id = ?", @current_user).first
  end
end
