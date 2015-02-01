require 'rails_helper'

describe Search, '.initialize' do
  it 'takes a term for searching' do
    search = Search.new(term: 'Lord')

    expect(search.term).to eq 'Lord'
  end
end

describe Search, '#songs' do
  context 'when #term matches one song' do
    it 'returns the matched song' do
      matched_song = create(:song, title: 'Lord I Lift')
      create(:song, title: 'Come Thou Fount')

      search = Search.new(term: 'Lord')

      expect(search.songs.length).to eq 1
      expect(search.songs.first).to eq matched_song
    end
  end

  context 'when #term matches more than one song' do
    it 'returns all matched songs' do
      create(:song, title: 'Come Thou Fount')
      matched_song1 = create(:song, title: 'Lord I Lift')
      matched_song2 = create(:song, title: 'Holy is the Lord')

      search = Search.new(term: 'Lord')

      expect(search.songs.length).to eq 2
      expect(search.songs).to match_array [matched_song1, matched_song2]
    end
  end
end
