class User

  include Mongoid::Document
  include Mongoid::Timestamps

  field :uid, type: BigDecimal
  field :name, type: String
  field :email, type: String

  has_many :items

  validates :uid, presence: true
  validates :name, presence: true
  validates :email, presence: true

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
      where(uid: auth[:uid].to_i).first
    end

    def create_from_auth(auth)
      addition = {
        email: auth[:info][:email],
        name: auth[:info][:name]
      }
      create(auth.merge(addition))
    end
  end

end
