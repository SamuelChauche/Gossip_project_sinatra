require 'sinatra'
require 'csv'
require_relative 'gossip'

class ApplicationController < Sinatra::Base
  # La route GET '/' affiche la liste de tous les potins sur la page d'accueil.
  # Elle utilise la méthode all de la classe Gossip pour récupérer tous les potins et les passe à la vue index.erb.
  get '/' do
    @gossips = Gossip.all
    erb :index
  end

  # La route GET '/gossips/new/' affiche le formulaire pour créer un nouveau potin.
  # Elle rend la vue new_gossip.erb.
  get '/gossips/new/' do
    erb :new_gossip
  end

  # La route POST '/gossips/new/' traite la soumission du formulaire pour créer un nouveau potin.
  # Elle récupère les valeurs d'auteur et de contenu du formulaire, crée une nouvelle instance de Gossip et l'enregistre.
  # Ensuite, elle redirige l'utilisateur vers la page d'accueil.
  post '/gossips/new/' do
    author = params[:gossip_author]
    content = params[:gossip_content]
    Gossip.new(author, content).save
    redirect '/'
  end

  # La route GET '/gossips/:id/' affiche les détails d'un potin spécifique.
  # Elle utilise la méthode find de la classe Gossip pour récupérer le potin correspondant à l'ID donné et le passe à la vue show.erb.
  get '/gossips/:id/' do
    id = params[:id]
    @gossip = Gossip.find(id)
    if @gossip
      erb :show
    else
      "Potin non trouvé"
    end
  end

  # La route GET '/gossips/:id/edit/' affiche le formulaire pour éditer un potin.
  # Elle utilise la méthode find de la classe Gossip pour récupérer le potin correspondant à l'ID donné et le passe à la vue edit.erb.
  get '/gossips/:id/edit/' do
    id = params[:id]
    @gossip = Gossip.find(id)
    if @gossip
      erb :edit
    else
      "Potin non trouvé"
    end
  end

  # La route POST '/gossips/:id/edit/' traite la soumission du formulaire pour mettre à jour un potin.
  # Elle récupère les nouvelles valeurs d'auteur et de contenu du formulaire et utilise la méthode update de la classe Gossip pour mettre à jour le potin.
  # Ensuite, elle redirige l'utilisateur vers la page de détails du potin.
  post '/gossips/:id/edit/' do
    id = params[:id]
    author = params[:gossip_author]
    content = params[:gossip_content]
    Gossip.update(id, author, content)
    redirect "/gossips/#{id}/"
  end
end
