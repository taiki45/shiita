class User

  include Mongoid::Document
  include Mongoid::Timestamps

  # Bignum extended in Root/lib/mongoid_ext.rb
  field :uid, type: Bignum
  field :name, type: String
  field :email, type: String
  field :following_ids, type: Array
  field :follower_ids, type: Array

  has_many :items, inverse_of: :user
  has_and_belongs_to_many :tags, index: true
  has_and_belongs_to_many :stocks, class_name: "Item", inverse_of: :stocked_users
  has_and_belongs_to_many :followings, class_name: "User", inverse_of: :followers, index: true
  has_and_belongs_to_many :followers, class_name: "User", inverse_of: :followings, index: true

  index uid: 1
  index email: 1

  validates :uid, presence: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validate :uniqueness_of_uid, if: :new_record?


  class << self
    def find_or_create_from_auth(auth)
      find_from_auth(auth) || create_from_auth(auth)
    end

    def find_by_part_of(email)
      expanded = email + "@" + Settings.email_domain
      find_by(email: expanded)
    end

    private

    def find_from_auth(auth)
      where(uid: auth[:uid]).first
    end

    def create_from_auth(auth)
      addition = {
        email: auth[:info][:email],
        name: auth[:info][:name],
      }
      create(auth.merge(addition))
    end
  end


  def following_items(limit = 20)
    item_ids = [tags, followings].map {|e| e.map {|ee| ee.item_ids } }.flatten.uniq
    result = Item.order_by(updated_at: -1).limit(limit).find(*item_ids)
    Array === result ? result : result ? [result] : []
  end

  def follow_user(user)
    followings.push user unless followings.include? user
  end

  def follow_tag(tag)
    tags.push tag unless tags.include? tag
  end

  def stock(item)
    stocks.push item unless stocks.include? item
  end

  def to_param
    email.split("@").first
  end

  private

  def uniqueness_of_uid
    errors.add(:unique_uid, "uid: #{uid} is not unique.") if self.class.where(uid: uid).count > 0
  end

end
