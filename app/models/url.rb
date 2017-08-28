class Url < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
  before_save do |user|
    user[:short_url] = shorten_url
  end

  def self.default_length
    8
  end

  def self.letter_array
    ('a'..'z').to_a + ('A'..'Z').to_a
  end

  def shorten_url
    long_url = self[:long_url]
    short_url = Url.letter_array.shuffle[(1..Url.default_length)].join('')
    return short_url
  end
end
