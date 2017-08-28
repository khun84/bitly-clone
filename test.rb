require_relative 'config/environments/init'
require_relative 'config/database'
require_relative 'app/models/url'

dummy_url = 'htt://www.facebook.com'
url = Url.new(long_url:dummy_url)
#
url.save
#
p url.errors.full_messages