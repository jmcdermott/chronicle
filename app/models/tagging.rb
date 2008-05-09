class Tagging < ActiveRecord::Base
  belongs_to :page
  belongs_to :tag
end
