require_relative 'config/environments/init'
require_relative 'config/database'
require_relative 'app/models/url'

urls = Url.all

urls.each_with_index do |idx, rec|
  p idx
  p rec

end