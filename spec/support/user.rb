def sign_up(email, password)
	visit root_path
	click_link "Sign up"	 
  fill_in "Email", with: email
  fill_in "Password", with: password
  fill_in "Password confirmation", with: password
  click_button "Sign up"	
end

def log_in(email, password)
	visit root_path
	click_link "Login"	 
  fill_in "Email", with: email
  fill_in "Password", with: password
  click_button "Log in"	
end

# create_articles()