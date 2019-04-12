class GamesController < ApplicationController
  before_action :get_game_and_check_permission, only: [:show, :edit, :update, :destroy]

  def index
    @games = Game.includes(:user).order('games.created_at desc, games.name')
    if params[:color_id]
      @games = @games.where(color_id: params[:color_id])
    elsif params[:user_id]
      @games = @games.where(user_id: params[:user_id])
    end
    unless user_manager?
      @games = @games.to_show_to_anyone
    end
  end

  def show
    @comments = @game.comments.includes(:user).order(:updated_at)
  end

  def new
    @game = Game.new
    authorize @game
  end

  def create
    @game = Game.new(game_params)
    @game.user_id = current_user.id
    authorize @game
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
    if @game.update(game_params)
      redirect_to game_path(@game)
    else
      render action: :edit
    end
  end

  def qrcodes
  end

  private

  def game_params
    p = [:name, :description, :color_id, :user_id, :sketch, :sit_start, :two_hands_start, :free_feet]
    p << :competition if user_manager?
    params[:game].permit(p)
  end

  def get_game_and_check_permission
    @game = Game.find(params[:id])
    authorize @game
  end
end
