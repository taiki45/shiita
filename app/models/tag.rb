class Tag

  include Mongoid::Document
  field :name, type: String

  has_and_belongs_to_many :users, index: true
  has_and_belongs_to_many :items, index: true

  index name: 1

  def to_param
    name
  end

end
