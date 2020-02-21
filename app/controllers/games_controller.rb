class GamesController < ApplicationController
  before_action :get_game_and_check_permission, only: [:show, :edit, :update, :destroy, :edit_pinnings, :pinnings]
  before_action :resize_image, only: [:create, :update]
  skip_before_action :verify_authenticity_token, only: [:pinnings]

  def index
    @games = Game.includes(:user).with_attached_image
    if params[:color_id]
      @games = @games.where(color_id: params[:color_id])
    elsif params[:user_id]
      @games = @games.where(user_id: params[:user_id])
    end
    if params[:competition] and user_manager?
      @games = @games.where(competition: true)
    end
    if params[:prototype]
      @games = @games.where('name like "%prototype%"')
    end
    unless user_manager?
      @games = @games.to_show_to_anyone
    end
    case params[:o]
    when 'name'
      @games = @games.order('games.name')
    when 'date'
      @games = @games.order('games.created_at desc')
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
      if @game.image.attached?
        # FIXME
        sleep 1
        redirect_to edit_pinnings_game_path(@game)
      else
        redirect_to game_path(@game)
      end
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
    @no_menu = true
  end

  def edit_pinnings
    @no_menu = true
  end

  # post
  # "_json"=>[{"x"=>72, "y"=>131, "hold_type"=>"start"}, {"x"=>218, "y"=>179, "hold_type"=>"start"}, {"x"=>384, "y"=>76, "hold_type"=>"hold"}]
  def pinnings
    image = params[:image]
    @game.update(pinnings: params[:holds])
    @game.create_pinned_image(image)
    render json: {}, status: :ok
  end

  private

  def game_params
    p = [:name, :description, :color_id, :user_id, :image, :video_url, :sit_start, :two_hands_start, :free_feet]
    p << :competition if user_manager?
    p << :user_id if user_admin?
    params[:game].permit(p)
  end

  # FIXME 
  def resize_image
    if _i = params[:game][:image] 
      image = MiniMagick::Image.new(_i.tempfile.path)
      if image.height < image.width and image.height > 800
        logger.info("image.resize height 800")
        image.resize "x800"
      elsif image.width < image.height and image.width > 800
        logger.info("image.resize width 800")
        image.resize "800x"
      end
    end
  end

  def get_game_and_check_permission
    @game = Game.find(params[:id])
    authorize @game
  end
end
