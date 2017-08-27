require_relative 'contact'
require 'sinatra'

get '/' do
  redirect to('/index')
end
get '/index' do
    erb :index
end

get '/contacts/new' do

    erb :new
end

get '/contacts/:id' do
  @title = 'My Contact list'
   @contact = Contact.find_by({id: params[:id].to_i})
   if @contact
     erb :show_contact
   else
     raise Sinatra::NotFound
   end
end

post '/contacts' do

  Contact.create(
  first_name: params[:first_name],
  last_name: params[:last_name],
  email: params[:email],
  note: params[:note]
  )
  redirect to('/contacts')
end

get '/contacts' do
   @title = 'My Contact list'
   @contacts = Contact.all

   erb :contacts
end

get '/about' do
  erb  :about
end

get '/contacts/:id/edit' do
  @contact = Contact.find_by(id: params[:id].to_i)

  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

put '/contacts/:id' do
@contact = Contact.find_by(id: params[:id].to_i)
if @contact
  @contact.update(
  first_name: params[:first_name],
  last_name:  params[:last_name],
  email:      params[:email],
  note:       params[:note]
  )

  redirect to('/contacts')
else
  rais Sinatara::NotFound
end

end

delete '/contacts/:id' do
   @contact = Contact.find(params[:id].to_i)

   if @contact
     @contact.delete
     redirect to('/contacts')
   else
     raise Sinatara::NotFound
   end
end





after do
  ActiveRecord::Base.connection.close
end
