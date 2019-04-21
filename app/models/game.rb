class Game < ApplicationRecord
  belongs_to :user
  belongs_to :color
  has_many :reactions
  has_many :comments

  has_one_attached :sketch

  serialize :cache_reactions_counts, Hash
  serialize :tags, Array

  validates :name, uniqueness: { scope: [:organization_id], message: "C'è già un blocco con questo nome." }
  before_save :clean_tags

  @@possible_tags = [:sit_start, :two_hands_start, :free_feet]

  IN_COMPETITION = false

  scope :to_show_to_anyone, -> { where(competition: IN_COMPETITION) }

  def to_s
    self.name
  end

  def show_to_anyone?
    self.competition == IN_COMPETITION
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
      if v and v != "0" and v != 0
        self.tags << t
      else
        self.tags.delete(t)
      end
    end
  end
end
