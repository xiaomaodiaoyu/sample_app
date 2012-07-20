require 'spec_helper'

describe "Static page" do

  let(:base_title) {"Ruby on Rails Tutorial Sample App"}
  
  describe "Home page" do
  	
    it "should have the content 'Sample App'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/home'
      page.should have_selector('h1', :text => 'Sample App')
    end

    it "should have the base title" do
    	visit '/static_pages/home'
    	page.should have_selector('title', 
    					:text => "#{base_title}")
    end

    it "should not have a custom page title" do
      visit '/static_pages/home'
      page.should_not have_selector('title', :text => '| Home')
    end

  end

  describe "Help page" do

    it "should have the content 'Help'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/help'
      page.should have_selector('h1', :text => 'Help')
    end

    it "should have the right title 'Help'" do
    	visit '/static_pages/help'
    	page.should have_selector('title', 
    					:text => "#{base_title} | Help")
  	end
  end

  describe "About page" do

    it "should have the content 'About Us'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/about'
      page.should have_selector('h1', :text => 'About Us')
    end

    it "should have the right title 'About Us'" do
    	visit '/static_pages/about'
    	page.should have_selector('title', 
    					:text => "#{base_title} | About Us")
  	end
end

end
