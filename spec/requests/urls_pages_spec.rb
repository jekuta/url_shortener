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

        it "should save the url" do
          expect { click_button "Shorten!" }.to change(Url, :count).by(1)
        end

        context "and 9 urls already in the database" do
          before { 9.times { Url.create(url: "http://example.com") } }

          it "should display the shortened url" do
            click_button "Shorten!"
            expect(page).to have_content(root_url+ "#{10.to_s(32)}")
          end
        end
      end

      context "with an invalid url" do
        before { fill_in "Url", with: "abc" }

        it "should not save the url" do
          expect { click_button "Shorten!" }.to change(Url, :count).by(0)
        end

        it "should display error" do
          click_button "Shorten!"
          expect(page).to have_content('Invalid url')
        end
      end
    end
  end

  describe "Show link page" do
    let(:url) { Url.create(url: "http://example.com") }

      before { visit "/#{url.id}!" }
    describe "url with and exclamation mark" do

      it "should take to the link page" do
        expect(current_path).to eq("/#{url.id}!")
        expect(page).to have_content(url.url)
      end
    end
  end
end
