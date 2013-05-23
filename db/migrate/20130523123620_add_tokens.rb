###
#
# When add Item#tokens do up
#
# When delete Item#tokens in the future, do down
#
class AddTokens < Mongoid::Migration
  def self.up
    Item.all.each do |item|
      item.generate_tokens
      item.save
    end
  end

  def self.down
    Item.all.each do |item|
      item.tokens = []
      item.save
    end
  end
end
