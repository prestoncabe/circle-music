class SongsController < ApplicationController
  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    @song.save
    redirect_to songs_path
  end

  def index
    @songs = Song.all
  end

  private

    def song_params
      params.required(:song).permit(:title)
    end
end
