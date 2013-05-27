require 'spec_helper'

describe User do

  it { should have_field(:uid).of_type(Bignum) }
  it { should have_field(:name).of_type(String) }
  it { should have_field(:email).of_type(String) }
  it { should be_timestamped_document }

  it { should have_many(:items)
       .with_foreign_key(:user_id)
       .of_type(Item)
       .ordered_by(:updated_at.desc)
  }

  it { should have_and_belong_to_many(:tags)
       .with_foreign_key(:tag_ids)
       .of_type(Tag)
       .with_index
       .ordered_by(:name.asc)
  }

  it { should have_and_belong_to_many(:stocks)
       .with_foreign_key(:stock_ids)
       .of_type(Item)
       .as_inverse_of(:stocked_users)
       .with_index
       .ordered_by(:updated_at.desc)
  }

  it { should have_and_belong_to_many(:followings)
       .with_foreign_key(:following_ids)
       .of_type(described_class)
       .as_inverse_of(:followers)
       .with_index
       .ordered_by(:email.asc)
  }

  it { should have_and_belong_to_many(:followers)
       .with_foreign_key(:follower_ids)
       .of_type(described_class)
       .as_inverse_of(:followings)
       .with_index
       .ordered_by(:email.asc)
  }

  it { should have_index_for(uid: 1).with_options(unique: true) }
  it { should have_index_for(email: 1).with_options(unique: true) }
  it { should have_index_for(tag_ids: 1).with_options(background: true) }
  it { should have_index_for(following_ids: 1).with_options(background: true) }
  it { should have_index_for(follower_ids: 1).with_options(background: true) }

  it { should_not allow_mass_assignment_of(:_id) }
  it { should_not allow_mass_assignment_of(:id) }
  it { should_not allow_mass_assignment_of(:_type) }

  it { should validate_presence_of(:uid) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:email) }


  describe "#uniqueness_of_uid" do
    context "when duplicated" do
      before { create :user }
      let(:duplicated) { build :user, email: "duplicated@test.com" }

      subject { duplicated.tap(&:invalid?) }
      it { should be_invalid }
      it { should have(1).error_on(:unique_uid) }
    end

    context "when not duplicated" do
      subject { build(:user).tap(&:valid?) }
      it { should be_valid }
      its(:errors) { should have(:no).error }
      it { should have(:no).error_on(:unique_uid) }
    end

    context "when update non duplicated user" do
      let(:user) { create :user }
      before do
        user.name = "john"
      end

      subject { user.tap(&:save) }
      it { should be_valid }
      its(:errors) { should have(:no).error }
      it { should have(:no).error_on(:unique_uid) }
    end
  end

  describe "#to_param" do
    subject { create :user }
    let(:fore_of_email) { subject.email.split("@").first }
    its(:to_param) { should eq fore_of_email }
  end

  describe "#following_items" do
    context "with fixtures" do
      before do
        tag = create :tag
        item = build(:item)
        @user = item.user
        item.tags = [tag]
        item.save
        @user.tags.push tag
      end

      subject { @user.following_items }
      it { should have(1).items }
    end
  end

  describe "#following?" do
    let(:user) { create :user }
    let(:other) { create :user, uid: 2, email: "other@example.com" }
    let(:tag) { create :tag }

    context "when confirm with other" do
      subject { user.following? other }

      context "when not following other" do
        it { should be_false }
      end

      context "when following other" do
        before { user.follow(other) }
        it { should be_true }
      end
    end

    context "when confirm with tag" do
      subject { user.following? tag }

      context "when not following the tag" do
        it { should be_false }
      end

      context "when following the tag" do
        before { user.follow(tag) }
        it { should be_true }
      end
    end
  end

  describe "#follow" do
    context "when follow other" do
      let(:user) { create :user }
      let(:other) { create :user, uid: 2, email: "other@example.com" }

      it "adds following to user" do
        expect {
          user.follow(other)
        }.to change { user.followings.count }.by(1)
      end

      it "adds follower to other" do
        expect {
          user.follow(other)
        }.to change { other.followers.count }.by(1)
      end
    end

    context "when follow tag" do
      let(:user) { create :user }
      let(:tag) { create :tag }

      it "adds following tags to user" do
        expect {
          user.follow(tag)
        }.to change { user.tags.count }.by(1)
      end

      it "adds followers to tag" do
        expect {
          user.follow(tag)
        }.to change { tag.users.count }.by(1)
      end
    end
  end


  let(:auth) do
    {
      :provider => "google_oauth2",
      :uid => "123456789012345678901",
      :info => {
        :name => "John Doe",
        :email => "john@company_name.com",
        :first_name => "John",
        :last_name => "Doe",
        :image => "https://lh3.googleusercontent.com/url/photo.jpg"
      },
      :credentials => {
        :token => "token",
        :refresh_token => "another_token",
        :expires_at => 1354920555,
        :expires => true
      },
      :extra => {
        :raw_info => {
          :id => "123456789012345678901",
          :email => "user@domain.example.com",
          :verified_email => true,
          :name => "John Doe",
          :given_name => "John",
          :family_name => "Doe",
          :link => "https://plus.google.com/123456789",
          :picture => "https://lh3.googleusercontent.com/url/photo.jpg",
          :gender => "male",
          :birthday => "0000-06-25",
          :locale => "en",
          :hd => "company_name.com"
        }
      }
    }
  end

  describe ".find_or_create_from_auth" do
    context "with auth fixture" do
      before do
      end

      context "when auth one user saved" do
        before do
          User.should_receive(:find_from_auth).and_return(create(:user))
          User.should_not_receive(:create_from_auth)
        end

        it "calls .find_from_auth" do
          User.find_or_create_from_auth(auth)
        end
      end

      context "when not saved auth one user" do
        before do
          User.should_receive(:find_from_auth).and_return(nil)
          User.should_receive(:create_from_auth).and_return(create(:user))
        end

        it "calls .create_from_auth" do
          User.find_or_create_from_auth(auth)
        end
      end
    end
  end

  describe ".create_from_auth" do
    context "with auth fixture" do
      subject { described_class.__send__ :create_from_auth, auth }

      its(:uid) { should eq 123456789012345678901 }
      its(:name) { should eq "John Doe" }
      its(:email) { should eq "john@company_name.com" }
      its(:info) { should have(5).attrs }
      its(:credentials) { should have(4).attrs }
      its(:extra) { should have_key :raw_info }
    end
  end

  describe ".find_from_auth" do
    context "with auth fixture" do
      let(:saved_one) { described_class.__send__ :create_from_auth, auth }

      subject { described_class.__send__ :find_from_auth, auth }
      its(:id) { should eq saved_one.id }
      its(:uid) { should eq saved_one.uid }
    end
  end

  describe ".validate_domain" do
    context "with valid domain auth" do
      before { Settings.stub(:email_domain).and_return("company_name.com") }
      subject { described_class.validate_domain(auth) }
      it { should be_true }
    end

    context "with invalid domain auth" do
      before { Settings.stub(:email_domain).and_return("invalid.com") }
      subject { described_class.validate_domain(auth) }
      it { should be_nil }
    end
  end

end
