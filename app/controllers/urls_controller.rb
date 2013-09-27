class UrlsController < ApplicationController
  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    if @url.save
      flash[:notice] = root_url+ @url.id.to_s(32)
      redirect_to root_path
    else
      flash[:error] = "Invalid url"
      redirect_to root_path
    end
  end

  def show
    id = params[:id].to_i(32)
    url = Url.find_by_id(id)
    if id != 0 && url
      redirect_to url.url
    else
      redirect_to root_path
    end
  end

  private
    def url_params
      params.require(:url).permit(:url)
    end
end
