class Item

  include Mongoid::Document
  include Mongoid::Timestamps

  field :source, type: String
  field :title, type: String

  belongs_to :user, index: true
  has_and_belongs_to_many :tags, index: true

  index updated_at: -1

  def tag_names
    tags.map {|e| e.name }.join(" ")
  end

  def tag_names=(names_string)
    self.tags = names_string.split(" ").map do |name|
      Tag.find_or_initialize_by(name: name)
    end
  end

end
