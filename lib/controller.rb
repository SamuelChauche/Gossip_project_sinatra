require 'sinatra'
require 'csv'
require_relative 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    @gossips = Gossip.all
    erb :index
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    author = params[:gossip_author]
    content = params[:gossip_content]
    Gossip.new(author, content).save
    redirect '/'
  end

  get '/gossips/:id/' do
    id = params[:id]
    @gossip = Gossip.find(id)
    if @gossip
      erb :show
    else
      "Potin non trouvé"
    end
  end

  get '/gossips/:id/edit/' do
    id = params[:id]
    @gossip = Gossip.find(id)
    if @gossip
      erb :edit
    else
      "Potin non trouvé"
    end
  end

  post '/gossips/:id/edit/' do
    id = params[:id]
    author = params[:gossip_author]
    content = params[:gossip_content]
    Gossip.update(id, author, content)
    redirect "/gossips/#{id}/"
  end
end
