class Tag < ActiveRecord::Base
  has_many :taggings, :dependent => :nullify
  has_many :pages, :through => :taggings
end
