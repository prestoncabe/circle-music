require 'spec_helper'

describe Search, '.initialize' do
  it 'takes a term for searching' do
    search = Search.new(term: 'Lord')

    expect(search.term).to eq 'Lord'
  end
end

describe Search, '#songs' do
  context 'when #term matches one song' do
    it 'returns the matched song' do
      # TODO: create specs-wide way to create a few example songs?
      create(:song, title: 'Lord I Lift')
      create(:song, title: 'Come Thou Fount')

      search = Search.new(term: 'Lord')

      expect(search.songs.length).to eq 1
      expect(search.songs.first.title).to eq 'Lord I Lift'
    end
  end

  context 'when #term matches more than one song' do
    it 'returns all matched songs' do
      create(:song, title: 'Come Thou Fount')
      create(:song, title: 'Lord I Lift')
      create(:song, title: 'Holy is the Lord')

      search = Search.new(term: 'Lord')

      expect(search.songs.length).to eq 2
      expect(search.songs.pluck(:title)).to match_array ['Lord I Lift', 'Holy is the Lord']
    end
  end
end
