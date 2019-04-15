module GameHelper
  def game_color(game)
  end

  def game_icon(game)
    if game.competition
      content_tag(:i, '', class: 'fas fa-trophy', style: "font-size: 18px; background-color: #{game.color.name}") 
    else
      content_tag(:i, '', class: 'fas fa-circle', style: "font-size: 18px; color: #{game.color.name}") 
    end
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
    content_tag(:i, '', class: "#{icon} #{reacted}", id: what.to_s)
  end

  def game_reaction(game, what)
    num = game.cache_reactions_count what
    icon = game_reaction_icon(what, reacted: (current_user && current_user.has_reactions?(game, what)))
    content_tag(:span, icon) + "<span id='#{what.to_s}_num'>#{num.to_i}</span>".html_safe
  end
end


