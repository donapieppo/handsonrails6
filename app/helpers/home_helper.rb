module HomeHelper
  def color_button_link(color)
    bgcolor, textcolor = color.bg_and_color
    icon = "<i style='font-size: 35px' class='#{color.icon}'></i>".html_safe
    link_to icon + '<br/>'.html_safe + I18n.t(color.name), games_path(color_id: color.id), 
      class: 'home-button', style: "color: #{textcolor}; background-color: #{bgcolor}"
  end
end
