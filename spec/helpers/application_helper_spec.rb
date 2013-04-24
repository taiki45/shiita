require 'spec_helper'

describe ApplicationHelper do

  describe "#login_path" do
    subject { helper.login_path }
    it { should eq "auth/google_oauth2" }
  end


  describe "#markdown" do

    context "with valid markdown text" do
      let(:valid) { "# TEST" }
      subject { helper.markdown valid }

      it { should match %r(<h1>TEST</h1>) }
    end

    context "with lacking markdown text" do
      let(:lacking_one) { "**test*" }
      subject { helper.markdown lacking_one }

      it { should match %r(<em>test</em>) }
    end

    describe "hard wrap mode" do
      context "with one new line text" do
        let(:one_new_line_text) { "test test\ntest test" }
        subject { helper.markdown one_new_line_text }

        it "should create only one br tag" do
          expect(subject).to match /<br>/
        end
      end

      context "with two new line text" do
        let(:two_new_line_text) { "test test\n\ntest test" }
        subject { helper.markdown two_new_line_text }

        it "should create p tags around paragraph" do
          result = subject.match(/(<p>).*(<p>)/m).captures
          expect(result).to have(2).match
        end
      end
    end

    context "with markdown text including some codes" do
      let(:text) { "```\ndef test\nend\n```" }
      subject { helper.markdown text }

      it { should match /CodeRay/ }
      it { should match /code/ }
      it { should_not match /style/ }
    end

    context "with text including some codes and language" do
      let(:text) { "```ruby\ndef test\nend\n```" }
      subject { helper.markdown text }

      it { should match /CodeRay/ }
      it { should match /code/ }
      it { should match /style/ }
    end

  end
end
