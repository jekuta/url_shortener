require 'spec_helper'

describe Url do
  before { @url = Url.new(url: 'http://example.com') }

  subject { @url }

  it { should respond_to(:url) }
  it { should respond_to(:visits) }
end
