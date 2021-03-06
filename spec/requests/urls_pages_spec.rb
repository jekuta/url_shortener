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
        before { fill_in "url", with: "http://example.com" }

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
        before { fill_in "url", with: "abc" }

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

  describe "Show link stats page" do
    let(:url) { Url.create(url: "http://example.com") }

    before do
      # HTTP_REFERERs are for the not yet existent feature of tracking incoming links
      2.times { get "/#{url.id}", nil, { 'HTTP_REFERER' => 'http://foo.com' } }
      3.times { get "/#{url.id}", nil, { 'HTTP_REFERER' => 'http://bar.com' } }
      visit "/#{url.id}+"
    end

    it "should take to the link stats page" do
      expect(current_path).to eq("/#{url.id}+")
      expect(page).to have_content('5')
    end
  end
end
