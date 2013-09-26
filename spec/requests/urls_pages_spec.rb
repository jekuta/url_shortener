require 'spec_helper'

describe "Urls Pages" do

  describe "New page" do
    before { visit '/urls/new' }

    it "should have the content 'Url Shortener App'" do
      expect(page).to have_content('Url Shortener App')
    end

    it "should have title 'Url Shortener App'" do
      expect(page).to have_title('Url Shortener App')
    end

    describe "url shortening" do

      context "with a valid url" do
        before { fill_in "Url", with: "http://example.com" }

        it "should the url to database" do
          expect { click_button "Shorten!".to change(Url, :count).by(1) }
        end

        it "should display the shortened url" do
          click_button "Shorten!"
          current_path.should == '/1'
        end

        context "and 9 urls already in the database" do
          before { 9.times { Url.create(url: "http://example.com") } }

          it "should displey the shortened url" do
            click_button "Shorten!"
            current_path.should == '/a'
          end
        end
      end
    end
  end
end
