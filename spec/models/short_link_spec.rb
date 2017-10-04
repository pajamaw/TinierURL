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
  describe "#base_conversion_to_slug" do
    it "will create a smaller string with a custom base 66 mapping based upon the id" do
      s1 = ShortLink.create(destination: "www.anything.com")
      s1.base_conversion_to_slug
      s1.save
      expect(s1.slug.length).to be < (s1.destination.length)
    end
  end
  describe "#base_conversion_to_slug" do
    it "contain reasonably map 1 trillion entries and still be under 8 characters" do
      s1 = ShortLink.create(id: 1000000000000, destination: "www.anything.com")
      s1.base_conversion_to_slug
      s1.save
      expect(s1.slug.length).to be < (8)
      ShortLink.find(1000000000000).delete
    end
  end
  describe "#validate_uri" do
    it "it will prevent non valid destinations from being created" do
      s1 = ShortLink.create(destination: "ww thing.com")
      expect(s1.valid?).to be(false)

    end
  end
  describe "#validate_uri" do
    it "it will allow valid structured url" do
      s1 = ShortLink.create(destination: "www.t.com")
      expect(s1.valid?).to be(true)
    end
  end
end
