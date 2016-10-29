class Feature < ActiveRecord::Base
  after_save :expire_cache

  def expire_cache
    Rails.cache.delete("feature_#{name}")
  end

  def self.enable!(name)
    f = Feature.find_by(name: name)
    if f
      f.update_attributes!(enabled: true)
    else
      Feature.create(name: name, enabled: true)
    end
  end

  def self.disable!(name)
    f = Feature.find_by(name: name)
    if f
      f.update_attributes!(enabled: false)
    else
      Feature.create(name: name, enabled: false)
    end
  end

  def self.reset!(name)
    f = Feature.find_by(name: name)
    if f
      f.update_attributes!(enabled: false)
    else
      Feature.create(name: name, enabled: nil)
    end
  end
end
