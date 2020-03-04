class HomeController < ApplicationController

  def index
    @last_games = Game.order('games.created_at desc').includes(:user, :color).limit(15)
    unless user_manager?
      @last_games = @last_games.to_show_to_anyone
    end
    @last_comments = Comment.order('comments.created_at desc').includes(:game, :user).limit(15)
    unless user_manager?
      @last_comments = @last_comments.where('games.competition != 1').references(:game)
    end
    @last_video_games = Game.order('games.video_at desc').where('LENGTH(games.video_url) > 0')
  end

  def ping
    render layout: false
  end

end
