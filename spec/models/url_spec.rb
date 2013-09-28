require 'spec_helper'

describe Url do
  before { @url = Url.new(url: 'http://example.com') }

  subject { @url }

  it { should respond_to(:url) }
  it { should respond_to(:visits) }

  describe "url without and url address" do
    before { @url.url = '' }

    it { should_not be_valid }
  end

  describe "url with an invalid url address" do
    before { @url.url = 'aaa' }

    it { should_not be_valid }
  end

  describe "url with a valid url address" do
    it "should be valid" do
      addresses = %w[http://example.com https://example.com example.com]

      addresses.each do |valid_address|
        @url.url = valid_address
        expect(@url).to be_valid
      end
    end
  end

  describe "url with a valid url address" do
    it "should be saved" do
      expect { @url.save! }.to change(Url, :count).by(1)
    end

    context "that has been saved" do
      before { @url.save! }

      it "should have 0 visits" do
        @url.visits.should == 0
      end
    end
  end
end
