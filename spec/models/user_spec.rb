require 'spec_helper'

describe User do

  describe "validations" do
    context "when it has unvalid data" do
      its(:valid?) { should be false }
    end

    context "when it has valid data" do
      subject { build :user }
      its(:valid?) { should be true }
    end
  end

  describe "#create" do
    before { create :user }
    subject { User.first }

    its(:uid) { should eq 1 }
    its(:name) { should eq "taiki" }
    its(:email) { should eq "taiki@example.com" }
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

  describe "#create_from_auth" do
    subject { described_class.__send__ :create_from_auth, auth }

    its(:uid) { should eq 123456789012345678901 }
    its(:name) { should eq "John Doe" }
    its(:email) { should eq "john@company_name.com" }
    its(:info) { should have(5).attrs }
    its(:credentials) { should have(4).attrs }
    its(:extra) { should have_key :raw_info }
  end

  describe "#find_from_auth" do
    before { @saved_one = described_class.__send__ :create_from_auth, auth }

    subject { described_class.__send__ :find_from_auth, auth }
    its(:id) { should eq @saved_one.id }
    its(:uid) { should eq 123456789012345678901 }
  end

end
