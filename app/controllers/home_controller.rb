class HomeController < ApplicationController

  def index
    @last_games = Game.order('games.created_at desc').includes(:user).limit(5)
    unless user_manager?
      @last_games = @last_games.to_show_to_anyone
    end
    @last_comments = Comment.order('comments.created_at desc').includes(:user).limit(5)
  end

  def ping
    render layout: false
  end

end
