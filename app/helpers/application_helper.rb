module ApplicationHelper
  def color_link(color)
    link_to content_tag(:i, '', class: 'fas fa-circle', style: "font-size: 18px; color: #{color.name}"), games_path(color_id: color.id), class: 'nav-link' 
  end
end
