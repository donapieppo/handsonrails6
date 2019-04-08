class GamesController < ApplicationController
  before_action :get_game_and_check_permission, only: [:show, :edit, :update, :destroy]

  def index
    @games = Game.includes(:user).order('games.name')
    if params[:color_id]
      @games = @games.where(color_id: params[:color_id])
    elsif params[:user_id]
      @games = @games.where(user_id: params[:user_id])
    end
  end

  def show
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user_id = User.first.id
    if @game.save
      redirect_to game_path(@game)
    else
      raise @game.errors.inspect
      render action: :new
    end
  end

  def edit
  end

  def update
    if @game.update_attributes(game_params)
      redirect_to game_path(@game)
    else
      render action: :edit
    end
  end

  def qrcodes
  end

  private

  def game_params
    params[:game].permit(:name, :description, :color_id, :user_id, :sketch)
  end

  def get_game_and_check_permission
    @game = Game.find(params[:id])
    authorize @game
  end
end
