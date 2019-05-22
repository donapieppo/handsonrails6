module GameHelper
  def game_color(game)
  end

  def game_icon(game)
    _icon = game.competition ? 'fas fa-trophy p-2' : 'fas fa-circle p-2'
    content_tag(:i, '', class: _icon, style: "font-size: 18px; color: #{game.color.name}") 
  end

  def qrcode(game)
    qr = RQRCode::QRCode.new(game_url(game))
    image_tag qr.as_png(size: 180).to_data_url 
  end

  def missing_image_tag
    '<i class="far fa-image" style="margin: auto; font-size: 200px"></i>'.html_safe
  end

  def game_reaction_icon(what, reacted: false)
    reacted = reacted ? 'reacted' : 'text-muted' 
    icon = case what 
    when :like
      "fas fa-heart fa-fw"
    when :hard
      "fas fa-pepper-hot fa-fw"
    when :soft
      "fas fa-feather-alt fa-fw" 
    when :working
      'fas fa-lock-open fa-fw'
    when :sent
      'fas fa-lock fa-fw'
    end
    content_tag(:i, '', class: "#{what.to_s}_icon #{icon} #{reacted}")
  end

  def link_to_game_reaction(game, what)
    icon = game_reaction_icon(what, reacted: (current_user && current_user.has_reactions?(game, what)))
    link_to icon + " " + t(what), toggle_game_reactions_path(game, w: what), remote: true
  end

  def game_reaction(game, what)
    num = game.cache_reactions_count what
    icon = game_reaction_icon(what, reacted: (current_user && current_user.has_reactions?(game, what)))
    content_tag(:span, icon) + "<span class='#{what.to_s}_num'>#{num.to_i}</span>".html_safe
  end
end


