require_relative 'contact'
require 'sinatra'

get '/' do
  redirect to('/index')
end
get '/index' do
    erb :index
end

get '/contacts/:id' do
  @title = 'My Contact list'
   @contacts = Contact.find_by({id: params[:id].to_i})
   erb :show_contact
end

get '/about' do
  erb  :about
end


after do
  ActiveRecord::Base.connection.close
end
