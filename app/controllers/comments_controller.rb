class CommentsController < ApplicationController
  def new
    @game = Game.find(params[:game_id])
    @comment = @game.comments.new
    authorize @comment
    render layout: false if modal_page?
  end

  def create 
    @game = Game.find(params[:game_id])
    @comment = @game.comments.new(user_id: current_user.id, name: params[:comment][:name])
    authorize @comment
    if @comment.save
      redirect_to game_path(@game)
    else
      render action: :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy
    redirect_to game_path(@comment.game_id)
  end
end
