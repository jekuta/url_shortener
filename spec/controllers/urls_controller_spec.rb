require 'spec_helper'
describe UrlsController do
  describe "GET #new" do
  end

  describe "GET #show" do

    context "with an id that maps to an url address" do
      let(:url) { Url.create(url: 'http://example.com') }

      it "should redirect to the url" do
        get :show, id: url.id
        expect(response.code).to eq('302')
        expect(response).to redirect_to(url.url)
      end

      it "should increment visits counter" do
        get :show, id: url.id
        Url.find(url).visits.should == 1
      end
    end

    context "with an id and a plus sign" do
      let(:url) { Url.create(url: 'http://example.com') }
      before { 2.times { get :show, id: url.id } }

      it "should show a stats page for the url" do
        pending
      end
    end

    context "with an id and an exclamation mark " do
      let(:url) { Url.create(url: 'http://example.com') }

      it "should show a link page for the url" do
        get :show, id: "#{url.id}!"
        response.should be_successful
        response.should render_template("show_link")
      end
    end

    context "with an id that doesn't map to an url address" do
      it "should redirect to new action" do
        get :show, id: 100
        expect(response.code).to eq('302')
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST #create" do
  end
end
