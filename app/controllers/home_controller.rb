class HomeController < ApplicationController

  def index
    @last_games = Game.order('games.created_at desc').includes(:user, :color).limit(5)
    unless user_manager?
      @last_games = @last_games.to_show_to_anyone
    end
    @last_comments = Comment.order('comments.created_at desc').includes(:game, :user).limit(5)
    unless user_manager?
      @last_comments = @last_comments.where('games.competition != 1')
    end
  end

  def ping
    render layout: false
  end

end
