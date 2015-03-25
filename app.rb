require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require "sinatra/json"

require './models/bookmark.rb'

set :bind, '192.168.33.10'
set :port, 3000

get '/' do
    @bookmarks = Bookmark.all
    erb :index
end

post '/create' do
    Bookmark.create(title: params[:title], url: params[:url])
    redirect "/"    
end

get '/api/site' do
    html = Nokogiri::HTML.parse(open(params[:url]))
    title =html.css('title').text
    data = {title: title}
    json data    
end