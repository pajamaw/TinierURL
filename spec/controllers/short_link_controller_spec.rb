RSpec.describe ShortLinkController do

  describe "Get index" do
    it "grabs the top 100 links" do
      get :index

      expect(response).to render_template(:index)
    end
  end
  describe "get show" do
    it "redirects to the destination page" do
      @short_link = ShortLink.first
      get :show, :params => {slug: @short_link.slug}
      # have to hack through due to the
      expect(response.headers["Location"]).to eq("http://#{@short_link.destination}")
    end
  end
end
