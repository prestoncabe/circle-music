class Search
  attr_reader :term

  def initialize(options={})
    @term = options.fetch(:term, '')
  end

  def songs
    Song.where('title LIKE ?', "%#{self.term}%")
  end
end
