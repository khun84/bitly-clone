get '/' do
  erb :"static/index"
end

post '/urls' do
  url = Url.new(long_url:params[:long_url])

  if url.save

  else
    redirect '/'
  end
end

get '/:short_url' do
  short_url = params[:short_url]
  url = Url.where('short_url = ?', short_url)[0]
  long_url = url[:long_url]
  # puts '+'*10
  # puts long_url
  # puts '+'*10

  if long_url.scan(/^.+\/\//).length == 0
    redirect 'http://' + long_url
  else
    redirect long_url
  end

end