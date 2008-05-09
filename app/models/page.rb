class Page < ActiveRecord::Base
  has_many :taggings, :dependent => :nullify
  has_many :tags, :through => :taggings, :uniq => true

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
    tag_string.split(',').each do |t|
      tag = Tag.find_or_create_by_name(t.strip)
      self.tags << tag unless self.tags.any? { |existing_tag| existing_tag == tag }
    end
  end

end
