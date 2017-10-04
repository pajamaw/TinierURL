RSpec.describe ShortLink do

  it "is valid with valid attributes" do
    expect(ShortLink.new(destination: 'anything.com')).to be_valid
    expect(ShortLink.new).not_to be_valid
  end
  it "parses the https away from with before_create callback" do
    s = ShortLink.create(destination: 'https://www.anything.com')
    expect(s.destination).to eq('anything.com')
  end
  it "doesn't parse the http:// away from with before_create callback" do
    s = ShortLink.create(destination: 'http://anything.com')
    expect(s.destination).to eq('anything.com')
  end
  it "doesn't parse the www away from with before_create callback" do
    s = ShortLink.create(destination: 'www.anything.com')
    expect(s.destination).to eq('www.anything.com')
  end
  it "has a case sensitive slug" do
    s1 = ShortLink.create(destination: "www.anything.com")
    s2 = ShortLink.create(destination: "www.anythingbut.com")
    s1.slug = s2.slug.capitalize
    # basically what I'm testing here is that the slug won't
    # bring back the first instance which will have the second
    # instance's slug but altered by a capitalized letter
    expect(ShortLink.find_by(slug: s2.slug)).to eq(s2)
  end
end
