RSpec.feature "tiny url creation", :type => :feature do
  scenario "User creates a tiny url" do
    visit "/"

    fill_in "short_link[slug]", :with => "www.miniwebtool.com/random-name-picker/"
    click_button "Create Short link"

    expect(page).to have_css("#notice")
  end
  scenario "User gets a previously made tiny url if the destination already exists" do
    visit "/"
    # first time time
    s = ShortLink.create(destination: "www.miniwebtool.com/random-name-picker/", visited: 10004)
    fill_in "short_link[slug]", :with => "www.miniwebtool.com/random-name-picker/"
    click_button "Create Short link"
    visit '/i/'
    expect(page).to have_text("miniwebtool", :count => 1)
  end
  scenario "User gets redirected for an invalid slug" do
    visit "/akjasdfds"

    expect(page.current_path).to eq("/")
  end
end
