class Comment

  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String
  field :user_id, type: String

  embedded_in :item

  validates :content, presence: true
  validates :user_id, presence: true

  def user
    User.find(user_id)
  end

  def user=(commenter)
    self.user_id = commenter.id
  end

end
