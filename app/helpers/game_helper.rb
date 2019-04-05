module GameHelper
  def current_user
    User.find(1)
  end

  def game_color(game)
  end

  def color_dot(game)
    content_tag :span, class: 'dot', style: "background-color: #{game.color.name}" do
      "  "
    end
  end

  def qrcode(game)
    qr = RQRCode::QRCode.new(game_url(game))
    image_tag qr.as_png(size: 180).to_data_url 
  end

  def missing_image_tag
    '<i class="far fa-image" style="font-size: 120px"></i>'.html_safe
  end

  def game_reaction_icon(what, muted: false)
    muted = muted ? 'text-muted' : ''
    icon = case what 
    when :like
      "fas fa-heart"
    when :hard
      "fas fa-pepper-hot"
    when :soft
      "fas fa-baby" 
    end
    content_tag(:i, '', class: "#{icon} #{muted} m-1")
  end

  def game_reaction(game, what)
    num = game.reactions.where(name: what.to_s).count
    icon = game_reaction_icon(what, muted: ! current_user.has_reactions?(game, what))
    link_to(icon, toggle_game_reactions_path(game, w: what), remote: true) + " #{num}"
  end
end


