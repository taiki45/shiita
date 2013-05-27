require 'spec_helper'

describe SyntaxHighlighting do

  describe "#block_code" do
    context "with tex code" do
      subject { described_class.new.block_code("test", "tex") }
      it { should match /math\/tex/ }
      it { should match /test/ }
    end

    context "with latex code" do
      subject { described_class.new.block_code("test", "latex") }
      it { should match /math\/tex/ }
      it { should match /test/ }
    end

    context "with ruby code" do
      subject { described_class.new.block_code("test", "ruby") }
      it { should match /CodeRay/ }
      it { should match /test/ }

      it "passes CodeRay.scan to language as string" do
        CodeRay.should_receive(:scan).with("test", "ruby").and_call_original
        subject
      end
    end

    context "with unknown language code" do
      subject { described_class.new.block_code("test", "unknown") }
      it { should match /CodeRay/ }
      it { should match /test/ }

      it "passes CodeRay.scan to language as :text" do
        CodeRay.should_receive(:scan).with("test", :text).and_call_original
        subject
      end
    end
  end

  describe "#codespan" do
    context "with usual codespan" do
      subject { described_class.new.codespan("test") }
      it { should match /code/ }
      it { should match /test/ }
    end

    context "with tex code using 2 $" do
      subject { described_class.new.codespan("$ test $") }
      it { should_not match /\$/ }
      it { should match /script/ }
      it { should match /math\/tex/ }
      it { should match /test/ }
    end

    context "with invalid tex code using 1 $" do
      subject { described_class.new.codespan("$ test") }
      it { should match /\$/ }
      it { should_not match /script/ }
      it { should_not match /math\/tex/ }
      it { should match /code/ }
      it { should match /test/ }
    end
  end

end
