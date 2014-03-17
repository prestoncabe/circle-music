module SongsHelper
  def delete_link song
    if current_user && current_user.can_delete_songs?
      link_to 'delete', song_path(song), method: :delete, data: {confirm: "Are you sure you want to delete \"#{song.title}\"?"}
    end
  end
end
