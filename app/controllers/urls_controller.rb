class UrlsController < ApplicationController
        def new
          @url = Url.new
        end
      
        def create
          @url = Url.new(url_params)
          @url.short_url = SecureRandom.hex(3)
      
          if @url.save
            redirect_to url_path(@url.short_url)
          else
            render :new
          end
        end
      
        def show
            @url = Url.find_by_short_url(params[:short_url])
          
            if @url.nil?
              flash[:error] = 'URL not found'
              redirect_to root_path
            else
              @urls = Url.all.order(created_at: :asc).paginate(page: params[:page], per_page: 10)
              render :show
            end
          end
          
        
        def redirect
          @url = Url.find_by_short_url(params[:short_url])
        
          if @url.nil?
            flash[:error] = 'URL not found'
            redirect_to root_path
          else
            redirect_to @url.long_url, allow_other_host: true
          end
        end
        
        private
      
        def url_params
          params.require(:url).permit(:long_url)
        end
            
end
