class Page < ActiveRecord::Base
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings, :uniq => true

  validates_presence_of :title, :message => 'is required'
  validates_presence_of :body,  :message => 'is required'

  def tag_list
    self.tags.map{|t| t.name}.join(", ")
  end

  def tag_list=(tag_string)
    if self.new_record?
      @tag_string = tag_string
    else 
      self.create_taggings(tag_string)
    end
  end

  def after_create
    self.tag_list = @tag_string if @tag_string
  end

  def create_taggings(tag_string)
    self.tags.delete(self.tags)
    self.tags.reset
    tag_string.split(',').each do |t|
      tag = Tag.find_or_create_by_name(t.strip)
      self.tags << tag 
    end
  end

end
