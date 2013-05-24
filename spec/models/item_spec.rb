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
  it { should have_index_for(stocked_user_ids: 1).with_options(background: true) }
  it { should have_index_for("comments.updated_at" => 1) }

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
  end

  shared_context "with tokens generated", tokens: :on do
    include_context "with stubed Mecab", mecab: :stubed
    before do
      item.generate_tokens
      item.save
    end
  end

  describe "#generate_tokens", mecab: :stubed do
    context %(with source is "test words" and tag name is "tag") do
      subject do
        item.tap {|o| o.generate_tokens }.tokens
      end

      it { should eq ["test", "words", "tag"] }
    end
  end

  describe ".search", tokens: :on do
    context "with no query" do
      subject { described_class.search(nil) }
      it { should have(:no).result }
    end

    context "with empty query" do
      subject { described_class.search("") }
      it { should have(:no).result }
    end

    context "with matched one word query" do
      before do
        Mecab::Ext::Parser.stub_chain("parse.surfaces.map.to_a").and_return(["test"])
      end
      subject { described_class.search("test").to_a }
      it { should have(1).result }
    end

    context "with unmatched one word query" do
      before do
        Mecab::Ext::Parser.stub_chain("parse.surfaces.map.to_a").and_return(["unmatched"])
      end
      subject { described_class.search("unmatched").to_a }
      it { should have(:no).result }
    end

    context "with matched two words query" do
      before do
        Mecab::Ext::Parser.stub_chain("parse.surfaces.map.to_a").and_return(["test", "tag"])
      end
      subject { described_class.search("test tag").to_a }
      it { should have(1).result }
    end

    context "with one matched two words query" do
      before do
        Mecab::Ext::Parser.stub_chain("parse.surfaces.map.to_a").and_return(["test", "unmatched"])
      end
      subject { described_class.search("test unmatched").to_a }
      it { should have(:no).result }
    end
  end

end
