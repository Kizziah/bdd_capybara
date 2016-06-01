require 'spec_helper'

RSpec.describe "User", type: :request do
  feature "Vistor signs up" do
	    scenario "with valid email and password", js: true do
	      sign_up("user@test.com", "hello123")
	      expect(page).to have_text "You have signed up successfully"
	    end

	    scenario "with incorrect email and valid password", js: true do
	    	sign_up("usertest.com", "hello123")
	    	expect(page).to_not have_text "You have signed up successfully"
	  	end

	  	scenario "with valid email and incorrect password", js: true do
	    	sign_up("user@test.com", "hello12")
	    	expect(page).to_not have_text "You have signed up successfully"
	  	end
  end

  feature "Existing User" do
    before(:each) do 
    	@u = FactoryGirl.create(:user)	
    end

    scenario "logs in, logs out, then logs back in", js: true do    	
			sign_up("user1@test.com", "hello123")
			click_link "Logout"
			click_link "Login"
			fill_in "Email", with: "user1@test.com"
  		fill_in "Password", with: "hello123"
			click_button "Log in"
			expect(page).to have_content "successfully"
    end

    scenario "logs in with valid email and password", js: true do    	
			log_in(@u.email, @u.password)
			expect(page).to have_content "Signed in successfully"
    end

    scenario "signs up with valid email and invalid password", js: true do
    	log_in(@u.email, @u.password+"m")
    	expect(page).to_not have_text "Signed in successfully"
  	end

  	scenario "signs up with invalid email and correct password", js: true do
    	log_in("#{@u.email}M", @u.password)
    	expect(page).to_not have_text "Signed in successfully"
  	end
  end


  feature "Admin User" do
    scenario "signs in as admin", js: true do
      
    end
  end

end
