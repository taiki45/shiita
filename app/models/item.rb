class Item

  include Mongoid::Document
  include Mongoid::Timestamps

  field :source, type: String
  field :title, type: String
  field :tokens, type: Array

  belongs_to :user, index: true, inverse_of: :items
  embeds_many :comments, order: :id.asc
  has_and_belongs_to_many :tags, index: true, order: :name.asc
  has_and_belongs_to_many :stocked_users, class_name: "User", inverse_of: :stocks, order: :email.asc

  index updated_at: -1
  index tokens: 1
  scope :recent, order_by(update_at: -1)

  validates :source, :title, presence: true
  validates :tags, associated: true, presence: true

  class << self
    def search(query)
      return [] if query.blank?
      all(tokens: tokenize(query)).sort(:updated_at.desc)
    end

    private

    def tokenize(sentence)
      Mecab::Ext::Parser.parse(sentence).surfaces.map(&:downcase).to_a
    end
  end

  def tag_names
    tags.map {|e| e.name }
  end

  def tag_names=(names)
    self.tags = names.map do |name|
      Tag.find_or_create_by(name: name) unless name.empty?
    end
  end

  def generate_tokens
    self.tokens = tokenize(source) + tags.map(&:name).map(&:downcase)
  end

  private

  def tokenize(*args)
    self.class.__send__(:tokenize, *args)
  end

end
