module HomeHelper
  @@icons = {
      'blue'   => "fas fa-child",
      'green'  => "fas fa-snowman",
      'yellow' => "fas fa-glass-martini-alt",
      'orange' => "fas fa-rocket",
      'purple' => "fas fa-bomb",
      'black'  => "fas fa-ambulance"
  }

  def bg_and_color(color)
    textcolor = 'white'
    textcolor = 'black' if (color.name == 'yellow' or color.name == 'orange')
    [color.name, textcolor]
  end

  def color_button_link(color)
    bgcolor, textcolor = bg_and_color(color)
    icon = "<i style='font-size: 35px' class='#{@@icons[color.name]}'></i>".html_safe
    link_to icon + ' ' + I18n.t(color.name), games_path(color_id: color.id), 
      class: 'home-button', style: "color: #{textcolor}; background-color: #{bgcolor}"
  end
end
