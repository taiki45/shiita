class Item
  include Mongoid::Document
  field :source, type: String
  field :title, type: String
  field :tags, type: Array
end
