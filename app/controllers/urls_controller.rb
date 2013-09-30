class UrlsController < ApplicationController
  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    if @url.save
      shortened_url = "#{root_url}#{@url.id.to_s(32)}"
      flash[:success] = "Your shortened url is <a href=\"#{shortened_url}\">#{shortened_url}</a>".html_safe
    else
      flash[:error] = "Invalid url"
    end
    redirect_to root_path
  end

  def show
    id = params[:id]
    last_char = id[-1]

    case last_char
    when '!' then show_link(id[0...-1])
    when '+' then show_link_stats(id[0...-1])
    else redirect_to_url(id)
    end
  end

  private
    def url_params
      params.require(:url).permit(:url)
    end

    def show_link(id)
      show_url(id) do |url|
        @url = url
        render 'show_link'
      end
    end

    def show_link_stats(id)
      show_url(id) do |url|
        @url = url
        render 'show_link_stats'
      end
    end

    def redirect_to_url(id)
      show_url(id) do |url|
        url.visits +=1
        url.save
        redirect_to url.url
      end
    end

    def show_url(id)
      # each url is saved by converting the id of the saved item into base 32
      id = id.to_i(32)
      url = Url.find_by_id(id)
      if id != 0 && url
        yield ( url )
      else
        redirect_to root_path
      end
    end
end
