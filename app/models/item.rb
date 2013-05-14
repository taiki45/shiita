class Item

  include Mongoid::Document
  include Mongoid::Timestamps

  field :source, type: String
  field :title, type: String

  belongs_to :user, index: true, inverse_of: :items
  embeds_many :comments, order: :update_at.desc
  has_and_belongs_to_many :tags, index: true, order: :name.asc
  has_and_belongs_to_many :stocked_users, class_name: "User", inverse_of: :stocks, order: :email.asc

  index updated_at: -1
  scope :recent, order_by(update_at: -1)

  validates :source, :title, presence: true
  validates_associated :tags

  def tag_names
    tags.map {|e| e.name }.join(" ")
  end

  def tag_names=(names_string)
    self.tags = names_string.split(" ").map do |name|
      Tag.find_or_create_by(name: name)
    end
  end

end
