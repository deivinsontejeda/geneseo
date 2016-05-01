class GamesController < ApplicationController

  def show
    user_id = params[:user_id]
    @game = Game.where("player_#{user_id}_id = ?", user_id).first
  end

  def move
    user_id = params[:user_id].to_i
    @game = Game.where("player_#{user_id}_id = ?", user_id).first

    @column = params[:column].to_i
    @game.turn(user_id, @column)

    @game = Game.where("player_#{user_id}_id = ?", user_id).first
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js
    end
  end

  def play
    user_id = params[:user_id].to_i
    @game = nil
    if Game.last.nil? and user_id == 1
      @game = Game.create(player_1_id: user_id, player_1_name: "User #{user_id}")
      @game.save
    else
      if Game.last.player_2_id.nil?
        @game = Game.last
        @game.player_2_id = user_id
        @game.player_2_name = "User #{user_id}"
        @game.start
        @game.save
      else
        @game = Game.create(player_1_id: user_id, player_1_name: "User #{user_id}")
      end
    end

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js
    end
  end

  def new
    @game = Game.new
  end

  def destroy
    user_id = params[:user_id].to_i
    @game = Game.where("player_#{user_id}_id = ?", user_id).first
    @game.delete
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js
    end
  end
end
