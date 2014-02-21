class VideosController < ApplicationController

	def index
		@videos = Video.all
		@comedy_obj = Category.find(1)
		@drama_obj = Category.find(2)
		@reality_obj = Category.find(3)
		@comedy = Video.comedy
		@drama = Video.drama
		@reality = Video.reality
		#@tv_comedies = Video.first(6)
		#@tv_dramas = Video.last(6)
	end

	def show
		@video = Video.find(params[:id])
	end

end