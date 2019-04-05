class ReactionsController < ApplicationController

  def toggle
    @game = Game.find(params[:game_id])

    # like, hard, soft
    what = params[:w] 
    if Reaction.permitted_reaction?(what)
      if r = current_user.reactions.where(name: what.to_s, game_id: @game.id,).first
        r.destroy
      else
        r = current_user.reactions.create(name: what.to_s, game_id: @game.id)
      end
    end
  end

end

