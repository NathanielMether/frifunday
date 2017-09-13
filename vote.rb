require 'sinatra'
require 'yaml/store'

get '/' do
  @title = 'Welcome to the Friday Funday, the most lovely codermonkeys!'
  erb :index
end

Choices = {
  'PONG' => 'Beer Pong Tournament - Nathaniel',
  'PINATA' => 'Piñata - Alex',
  'KARAOKE_1' => "Glenn said 'Isabelle said Karaoke' - Glenn? Isabelle? !@\#$%^",
  'KARAOKE_2' => "Isabelle said 'Isabelle says Glenn said Karaoke' - ......",
  'CODE' => "24hoursfridayfundayhackathon.code4ever.hashtagcoderhasnolife - Chen",
  'COOKING' => "Vintage cooking competition - Cholena"
}

post '/cast' do
  @title = 'Thanks for casting your vote!'
  @vote  = params['vote']
  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    @store['votes'] ||= {}
    @store['votes'][@vote] ||= 0
    @store['votes'][@vote] += 1
  end
  erb :cast
end

get '/results' do
  @title = 'Results so far:'
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end
