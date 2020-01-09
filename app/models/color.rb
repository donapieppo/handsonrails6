class Color < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false }
  has_many :games

  @@colors = {
      'blue'   => "#0070C0",
      'green'  => "#339933",
      'yellow' => "#FFFF5C",
      'yellow' => "#D6D633",
      'orange' => "#FFB733",
      'purple' => "#993399",
      'black'  => "#333333"
  }

  @@icons = {
      'blue'   => "fas fa-bicycle",
      'green'  => "far fa-grin-beam",
      'yellow' => "fas fa-glass-martini-alt",
      'orange' => "fas fa-rocket",
      'purple' => "fas fa-bomb",
      'black'  => "fas fa-ambulance"
  }

  def to_html
    @@colors[name]
  end

  def bg_and_color
    textcolor = 'white'
    textcolor = 'black' if (name == 'yellow' or name == 'orange')
    [to_html, textcolor]
  end

  def icon
    @@icons[name]
  end
end
