class LinksController < ApplicationController
  before_filter :authorize

  def new
    @song = Song.find(params[:song_id])
    @link = @song.links.new
  end

  def create
    @song = Song.find(params[:song_id])
    @link = @song.links.new(link_params)
    @link.save

    redirect_to @song
  end

  private

  def link_params
    params.required(:link).permit(:name, :url)
  end
end
