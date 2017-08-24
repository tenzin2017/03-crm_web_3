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
   if @contacts
     erb :show_contact
   else
     raise Sinatra::NotFound
   end
end

get '/contacts' do
   @title = 'My Contact list'
   @contacts = Contact.all

   erb :contacts
end

get '/about' do
  erb  :about
end


after do
  ActiveRecord::Base.connection.close
end
