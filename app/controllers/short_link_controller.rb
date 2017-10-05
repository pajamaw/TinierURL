class ShortLinkController < ApplicationController
  def index
    # secret feature to see the top x number of sites
    if params[:number] && params[:number].to_i < ShortLink.count
      @num = params[:number].to_i
      @short_links = ShortLink.take(@num)
      # use take as i've setup the table to be sorted by visited
    else
      @num = 100
      @short_links = ShortLink.take(@num)
    end
  end

  def new
    @short_link = ShortLink.new
    @count = ShortLink.count
    # hacky at the moment
  end

  def show
    if !@short_link = ShortLink.find_by(slug: params[:slug])
      redirect_to root_path, notice: "Path not found" and return
    end
    @short_link.visited += 1
    @short_link.save
    redirect_to "http://#{@short_link.destination}", status: 302
  end

  def custom_show
    if !@short_link = ShortLink.find_by(slug: params[:custom_slug], custom_slug: true)
      redirect_to root_path, notice: "Path not found" and return
    end
    @short_link.visited += 1
    @short_link.save
    redirect_to "http://#{@short_link.destination}", status: 302
  end

  def create
    # find or create normal
    if params[:short_link][:slug] == ""
      @short_link = ShortLink.find_by(destination: params[:short_link][:destination]) || ShortLink.create(short_link_params)
    else
      # create custom
      @short_link = ShortLink.find_by(short_link_params) || ShortLink.create(short_link_params)
    end
    respond_to do |format|

      if @short_link.save
        if params[:short_link][:slug] != ""
          #provide with a different slug if they want a unique path
          format.html { redirect_to root_path, notice: "#{request.original_url.slice(0..-3)}a/#{@short_link.slug}"}
        else
          format.html { redirect_to root_path, notice: "#{request.original_url.slice(0..-3) + @short_link.slug}"}
        end
      else
        format.html { redirect_to root_path, notice: "#{@short_link.errors[:destination][0]}" }
      end
    end
  end

  private

    def short_link_params
      params.require(:short_link).permit(:destination, :slug)
    end

end
