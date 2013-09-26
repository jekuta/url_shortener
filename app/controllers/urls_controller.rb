class UrlsController < ApplicationController
  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    if @url.save
      redirect_to "/#{@url.id.to_s(32)}"
    else
      flash[:error] = "Invalid url"
      render 'new'
    end
  end

  def show

  end

  private
    def url_params
      params.require(:url).permit(:url)
    end
end
