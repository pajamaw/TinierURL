class ShortLinkController < ApplicationController
  def index
    @short_links = ShortLink.take(100)
    # @short_links.map{|sl| a = {destination: sl.destination, slug: sl.slug, visited: sl.visited}}
    @short_link = ShortLink.new
  end

  def show
    if !@short_link = ShortLink.find_by(slug: params[:slug])

      redirect_to root_path, notice: "Path not found" and return
    end
    @short_link.visited += 1
    @short_link.save
    redirect_to "http://#{@short_link.destination}", status: 302
  end

  def create
    @short_link = ShortLink.find_by(short_link_params) || ShortLink.create(short_link_params)
    respond_to do |format|
      if @short_link.save
        format.html { redirect_to root_path, notice: "#{request.original_url.slice(0..-3) + @short_link.slug}"}
      else
        format.html { redirect_to root_path, notice: "#{@short_link.errors[:destination][0]}" }
      end
    end
  end

  def destroy
    @short_link.destroy
    respond_to do |format|
      format.html { redirect_to short_links_url, notice: 'Short link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def short_link_params
      params.require(:short_link).permit(:destination)
    end

end
