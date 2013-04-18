class User
  include Mongoid::Document
  field :uid, type: Integer
  field :name, type: String
  field :email, type: String
end
