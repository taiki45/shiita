class Item

  include Mongoid::Document
  include Mongoid::Timestamps

  field :source, type: String
  field :title, type: String
  field :tags, type: Array

  belongs_to :user

end
