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
    content_tag(:i, '', class: "#{icon} #{muted} m-1", id: what.to_s)
  end

  def game_reaction(game, what, editable: true)
    num = game.cache_reactions_count what
    icon = game_reaction_icon(what, muted: (! current_user || ! current_user.has_reactions?(game, what)))
    if editable and current_user 
      link_to(icon, toggle_game_reactions_path(game, w: what), remote: true) + "<span id='#{what.to_s}_num'>#{num.to_i}</span>".html_safe
    elsif editable
      link_to(icon, login_path, title: "Prima di commentare ti chiediamo di accedere (menu / accedi).") + "<span id='#{what.to_s}_num'>#{num.to_i}</span>".html_safe
    else
      content_tag :span, icon + " #{num}", title: "Per commentare visulizza il blocco cliccando sull'immagine."
    end
  end
end


