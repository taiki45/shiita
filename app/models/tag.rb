class Tag

  include Mongoid::Document
  field :name, type: String

  has_and_belongs_to_many :items

  def to_param
    name
  end

end
