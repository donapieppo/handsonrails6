module ApplicationHelper
  def color_link(color)
    link_to content_tag(:i, '', class: 'fas fa-circle', style: "font-size: 16px; color: #{color.name}"), games_path(color_id: color.id), class: 'nav-link p-1' 
  end

  def link_to_delete(name = "", url, button: false)
    link_to '<i class="fas fa-trash-alt fa-fw"></i>'.html_safe + " " + name, url, method: :delete, title: 'elimina', data: {confirm: 'Siete sicuri di voler cancellare?'}, class: (button ? 'button' : '')
  end

  # from https://github.com/seyhunak/twitter-bootstrap-rails
  ALERT_TYPES = [:success, :info, :warning, :danger]
  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      next if message.blank?

      type = type.to_sym
      type = :success if type.to_s == :notice.to_s
      type = :danger  if type.to_s == :alert.to_s
      type = :danger  if type.to_s == :error.to_s
      next unless ALERT_TYPES.include?(type)

      icon = (type == :danger) ? 'exclamation-triangle' : 'info-circle'

      Array(message).each do |msg|
        text = content_tag(:div,
                           icon(icon) + ' ' + msg.html_safe + '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'.html_safe,
                           class: "alert alert-#{type} alert-dismissible fade show", role: 'alert')
        flash_messages << text.html_safe if msg
      end
    end
    flash_messages.join("\n").html_safe
  end

  def main_title(srt)
    srt = srt.to_s unless srt.is_a?(String)
    if modal_page?
      javascript_tag("$('#main-modal .modal-title').html('#{j srt}')")
    else
      content_tag(:h1, srt)
    end
  end

  def icon(i, txt='')
    "<i class='#{i}'></i>".html_safe + ' ' + txt
  end

end
