class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :game

  @@rtypes = [:like, :soft, :hard]

  def self.permitted_reaction?(what)
    @@rtypes.include?(what.to_sym)
  end


end

