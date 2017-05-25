require 'pry'

class Captain < ActiveRecord::Base

  has_many :boats

  scope :catamaran, -> {joins(boats: :classifications).where(classifications:{name:'Catamaran'})}
  scope :motorboat, -> {joins(boats: :classifications).where(classifications:{name:'Motorboat'})}
  scope :sailboat,  -> {joins(boats: :classifications).where(classifications:{name:'Sailboat'})}
  scope :cap_n_boats, -> {joins(boats: :classifications)}

  def self.catamaran_operators
    Captain.catamaran.uniq
  end

  def self.sailors
    Captain.sailboat.uniq
  end

  def self.talented_seamen
    Captain.motorboat.where(id: Captain.sailboat.pluck(:id))
  end

  def self.non_sailors
    Captain.cap_n_boats.uniq.where.not(id: Captain.sailboat.pluck(:id))
  end
  
end
