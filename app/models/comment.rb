class Comment

  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String
  field :user_id, type: String

  embedded_in :item

  validates :content, presence: true
  validates :user_id, presence: true

  class << self
    def new_with_user(attrs)
      attrs[:user_id] = attrs.delete(:user).id
      new(attrs)
    end
  end

  def user
    User.find(user_id)
  end

end
