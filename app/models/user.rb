class User

  include Mongoid::Document
  include Mongoid::Timestamps

  # Bignum extended in Root/lib/mongoid_ext.rb
  field :uid, type: Bignum
  field :name, type: String
  field :email, type: String

  has_many :items
  has_and_belongs_to_many :tags, index: true
  has_and_belongs_to_many :users, index: true

  index uid: 1
  index email: 1

  validates :uid, presence: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validate :uniqueness_of_uid

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
        name: auth[:info][:name]
      }
      create(auth.merge(addition))
    end
  end

  def to_param
    email.split("@").first
  end

  def following_items
    item_ids = [tags, users].map {|e| e.map {|ee| ee.item_ids } }.flatten.uniq
    result = Item.order_by(updated_at: -1).find(*item_ids)
    Array === result ? result : [result]
  end

  private

  def uniqueness_of_uid
    errors.add(:unique_uid, "uid: #{uid} is not unique.") if self.class.where(uid: uid).count > 0
  end

end
