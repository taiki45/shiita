class Item

  include Mongoid::Document
  include Mongoid::Timestamps

  field :source, type: String
  field :title, type: String

  belongs_to :user
  has_and_belongs_to_many :tags

end
