require 'byebug'

get '/' do
  @urls = Url.all
  erb :"static/index"
end

post '/urls' do
  @url = Url.new(long_url:params[:long_url])
  @url[:click_count] = 0

  @url.save

  if @url.save
    @url[:short_url] = "http://localhost:9393/#{@url[:short_url]}"
    return @url.to_json
  #   # redirect '/'
  else
    return @url.errors.to_json
  # #   # erb :"static/error"
  # #   return @messages
  end
end

get '/:short_url' do
  short_url = params[:short_url]
  url = Url.where('short_url = ?', short_url)[0]
  if url.nil?
    @messages = ['There is no such short url']
    erb :'static/error'
  else
    # url = urls[0]
    count = url[:click_count]+1
    long_url = url[:long_url]
    url.update_column(:click_count,count)

    redirect long_url


  end


end