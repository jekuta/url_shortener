class UrlsController < ApplicationController
  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    if @url.save
      flash[:notice] = root_url+ @url.id.to_s(32)
    else
      flash[:error] = "Invalid url"
    end
    redirect_to root_path
  end

  def show
    if params[:id][-1] == '!'
      id = params[:id][0...-1].to_i(32)
      url = Url.find_by_id(id)
      if id != 0 && url
        @url = url
        render 'show_link'
      end
    else
      id = params[:id].to_i(32)
      url = Url.find_by_id(id)
      if id != 0 && url
        url.visits += 1
        url.save
        redirect_to url.url
      else
        redirect_to root_path
      end
    end
  end

  private
    def url_params
      params.require(:url).permit(:url)
    end
end
