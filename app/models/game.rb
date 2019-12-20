# https://evilmartians.com/chronicles/rails-5-2-active-storage-and-beyond
class Game < ApplicationRecord
  belongs_to :user
  belongs_to :color
  has_many :reactions, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :image
  has_one_attached :pinned_image

  serialize :pinnings, JSON
  serialize :cache_reactions_counts, Hash
  serialize :tags, Array

  validates :name, uniqueness: { message: "C'è già un blocco con questo nome.", case_sensitive: false }

  before_save :clean_tags

  @@possible_tags = [:sit_start, :two_hands_start, :free_feet]

  IN_COMPETITION = false

  scope :to_show_to_anyone, -> { where(competition: IN_COMPETITION) }

  def to_s
    self.name
  end

  def show_to_anyone?
    if self.competition
     || self.competition == IN_COMPETITION
    else
      true
    end
  end

  def update_reactions_counts
    self.cache_reactions_counts = {}
    Reaction.each_types do |t|
      self.cache_reactions_counts[t] = self.reactions.where(name: t).count
    end
    self.save
  end

  def cache_reactions_count(what)
    cache_reactions_counts[what.to_sym].to_i
  end

  def clean_tags
    self.tags = self.tags & @@possible_tags
  end

  def self.each_tags
    @@possible_tags.each do |t|
      yield t
    end
  end

  # FIXME
  # g.sit_start = "0"
  # g.sit_start = "1"
  @@possible_tags.each do |t|
    self.define_method(t) do
      self.tags.include?(t)
    end
    self.define_method("#{t}=") do |v|
      if v && v != '0' && v != 0
        self.tags << t
      else
        self.tags.delete(t)
      end
    end
  end

  # def image_preview_filename
  #   File.join Rails.root, 'public', 'pinnings', "#{self.id}.png"
  # end

  # def image_preview_url
  #   Rails.configuration.relative_url_root + "/pinnings/#{self.id}.png"
  # end

  CHAR_TO_SKIP = "data:image/png;base64,".size
  def create_pinned_image(img)
    blob = Base64.decode64(img[CHAR_TO_SKIP..-1])
    pinning_image = MiniMagick::Image.read(blob)
    wall_image    = MiniMagick::Image.new(ActiveStorage::Blob.service.send(:path_for, self.image.key))
    result = wall_image.composite(pinning_image) do |c|
      c.compose "Atop" # OverCompositeOp
    end
    self.pinned_image.attach(io: File.open(result.path), filename: "pinned_image_#{self.id}")
  end
end

# convert -compress None big.jpg -crop 200x160+160+80 small.jpg -compose atop -composite result.jpg
# convert rose: -gravity Center  -crop 32x32+0+0 +repage  crop_center.gif


