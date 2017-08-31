require 'URI'
require 'active_record'

class Url < ActiveRecord::Base

  validates :long_url, presence: true, format: {with: URI.regexp(['http', 'https'])}, uniqueness: true
  validates :short_url, uniqueness: true


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

  def self.short_url_valid?(short_url)
    if Url.find_by('short_url = ?', short_url).nil?
      true
    else
      false
    end
  end

  def shorten_url
    long_url = self[:long_url]
    short_url = Url.letter_array.shuffle[(1..Url.default_length)].join('')
    while !Url.short_url_valid?(short_url) do
      short_url = Url.letter_array.shuffle[(1..Url.default_length)].join('')
    end

    return short_url
  end
end

