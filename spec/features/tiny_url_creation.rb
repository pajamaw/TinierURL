RSpec.feature "tiny url creation", :type => :feature do
  scenario "User creates a tiny url" do
    visit "/"

    fill_in "Destination", :with => "www.miniwebtool.com/random-name-picker/"
    click_button "Create Short link"

    expect(page).to have_css("#notice")
  end
  scenario "User gets a previously made tiny url if the destination already exists" do
    visit "/"
    s = ShortLink.create(destination: "www.miniwebtool.com/random-name-picker/")
    fill_in "Destination", :with => "www.miniwebtool.com/random-name-picker/"
    click_button "Create Short link"

    expect(page).to have_css("tr", :count => 2)
  end
  scenario "User gets a previously made tiny url if the destination already exists" do
    visit "/"
    s = ShortLink.create(destination: "www.miniwebtool.com/random-name-picker/")
    fill_in "Destination", :with => "www.miniwebtool.com/random-name-picker/"
    click_button "Create Short link"

    expect(page).to have_css("tr", :count => 2)
  end

end
