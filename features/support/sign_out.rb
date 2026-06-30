After('@sign_out') do
  click_button "Sign out" if page.has_button?("Sign out", wait: 0)
end
