class HomeController < ApplicationController

  def index
    @last_comments = Comment.order('comments.created_at desc').includes(:user).limit(5)
  end

end
