class GamesController < ApplicationController
  before_action :get_game_and_check_permission, only: [:show, :edit, :update, :destroy, :edit_pinnings, :pinnings]
  skip_before_action :verify_authenticity_token, only: [:pinnings]

  def index
    @games = Game.includes(:user).with_attached_image
    if params[:color_id]
      @games = @games.where(color_id: params[:color_id]).order('games.created_at desc, games.name')
    elsif params[:user_id]
      @games = @games.where(user_id: params[:user_id]).order('games.created_at desc, games.name')
    end
    if params[:competition] and user_manager?
      @games = @games.where(competition: true).order('games.color_id, games.name')
    end
    unless user_manager?
      @games = @games.to_show_to_anyone
    end
  end

  def show
    @comments = @game.comments.includes(:user).order(:updated_at)
    respond_to do |format|
      format.html
      # format.json {render json: @game.to_json(include: :user, only: [:id, :name]) }
    end
  end

  def new
    @game = Game.new(user_id: current_user.id)
    authorize @game
  end

  def create
    @game = Game.new(game_params)
    @game.user_id = current_user.id unless user_admin?
    authorize @game
    if @game.save
      redirect_to game_path(@game)
    else
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

  def destroy
    if @game.destroy
      flash[:notice] = "Il blocco è stato cancellato."
    else
      flash[:error] = "Non è stato possibile eliminare il blocco."
    end
    redirect_to root_path
  end

  def qrcodes
  end

  def edit_pinnings
  end

  # post
  # "_json"=>[{"x"=>72, "y"=>131, "hold_type"=>"start"}, {"x"=>218, "y"=>179, "hold_type"=>"start"}, {"x"=>384, "y"=>76, "hold_type"=>"hold"}]
  def pinnings
    @game.update(pinnings: params[:_json])
    render json: {}, status: :ok
  end

  private

  def game_params
    p = [:name, :description, :color_id, :user_id, :image, :sit_start, :two_hands_start, :free_feet]
    p << :competition if user_manager?
    p << :user_id if user_admin?
    resize_image
    params[:game].permit(p)
  end

  def resize_image
    if _i = params[:game][:image] 
      image = MiniMagick::Image.new(_i.tempfile.path)
      if image.height < image.width and image.height > 800
        image.resize "x800"
      elsif image.width < image.height and image.width > 800
        image.resize "800x"
      end
    end
  end

  def get_game_and_check_permission
    @game = Game.find(params[:id])
    authorize @game
  end
end
