class User

  include Mongoid::Document

  field :uid, type: BigDecimal
  field :name, type: String
  field :email, type: String

  class << self
    def find_or_create_from_auth(auth)
      find_from_auth(auth) || create_from_auth(auth)
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

end
