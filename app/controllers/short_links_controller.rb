class ShortLinksController < ApplicationController

  # GET /short_links
  # GET /short_links.json
  def index
    @short_links = ShortLink.all
    @short_link = ShortLink.new
  end

  def show
    @short_url = ShortLink.find(params[:slug])
    @short_url.update_attributes!(visited: @short_url.visited + 1)
    redirect_to "http://#{@short_url.destination}", status: 302
  end

  # POST /short_links
  # POST /short_links.json
  def create
    @short_link = ShortLink.new(short_link_params)

    respond_to do |format|
      if @short_link.save
        format.html { redirect_to @short_link, notice: 'Short link was successfully created.' }
        format.json { render :show, status: :created, location: @short_link }
      else
        format.html { render :new }
        format.json { render json: @short_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /short_links/1
  # PATCH/PUT /short_links/1.json
  def update
    respond_to do |format|
      if @short_link.update(short_link_params)
        format.html { redirect_to @short_link, notice: 'Short link was successfully updated.' }
        format.json { render :show, status: :ok, location: @short_link }
      else
        format.html { render :edit }
        format.json { render json: @short_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /short_links/1
  # DELETE /short_links/1.json
  def destroy
    @short_link.destroy
    respond_to do |format|
      format.html { redirect_to short_links_url, notice: 'Short link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_short_link
      @short_link = ShortLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def short_link_params
      params.require(:short_link).permit(:slug, :visited, :destination)
    end
end
