require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

      it "should have the content 'Aquatics App'" do
        visit '/static_pages/home'
        expect(page).to have_content('Aquatics App')
      end

      it "should have the title 'Home'" do
        visit '/static_pages/home'
        expect(page).to have_title("Aquatics App | Home")
      end
    end
end