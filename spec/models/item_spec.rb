require 'spec_helper'

describe Item do

  it { should have_field(:title).of_type(String) }
  it { should have_field(:source).of_type(String) }
  it { should have_field(:tokens).of_type(Array) }
  it { should be_timestamped_document }

  it { should belong_to(:user).with_foreign_key(:user_id).of_type(User) }

  it { should embed_many(:comments)
       .of_type(Comment)
       .ordered_by(:id)
  }

  it { should have_and_belong_to_many(:tags)
       .with_foreign_key(:tag_ids)
       .of_type(Tag)
       .ordered_by(:name)
  }

  it { should have_and_belong_to_many(:stocked_users)
       .with_foreign_key(:stocked_user_ids)
       .of_type(User)
       .as_inverse_of(:stocks)
       .ordered_by(:email)
  }

  it { should have_index_for(updated_at: -1) }
  it { should have_index_for(user_id: 1).with_options(background: true) }
  it { should have_index_for(tag_ids: 1).with_options(background: true) }

  it { should validate_presence_of(:source) }
  it { should validate_presence_of(:title) }
  it { should validate_associated(:tags) }
  it { should validate_presence_of(:tags) }


  describe "#tag_names" do
    subject { build(:item).tap {|e| e.tags = [create(:tag)] } }
    its(:tag_names) { should eq subject.tags.map {|e| e.name } }
  end


  shared_context "with stubed Mecab", mecab: :stubed do
    let(:test_words) { ["test", "words"] }

    let(:item) do
      Item.create(
        title: "test",
        source: test_words,
        tags: [Tag.create(name: "tag")]
      )
    end

    before do
      Mecab::Ext::Parser.stub_chain("parse.surfaces.map.to_a").and_return(test_words)
    end

    shared_context "with real MeCab", mecab: :real do
      before do
        Mecab::Ext::Parser.unstub(:parse)
        item.source = "anohter words"
        item.generate_tokens
        item.save
      end
    end
  end

  describe "#generate_tokens", mecab: :stubed do
    subject do
      item.tap {|o| o.generate_tokens }.tokens
    end

    it { should eq ["test", "words", "tag"] }

    if defined? MeCab
      context "with real MeCab", mecab: :real do
        subject { item.tokens }
        it { should eq ["anohter", "words", "tag"] }
      end
    end
  end

  describe ".search" do
  end

end
