require 'gossip'

class ApplicationController < Sinatra::Base
  # Opération get sur la page '/' qui prend la requête du visiteur et l'envoie vers l'index
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  # Opération get sur la page '/gossips/new/' qui prend la requête du visiteur et l'envoie vers
  get '/gossips/new/' do
    erb :new_gossip
  end

  # On créé une nouvelle gossip via le formulaire de la page new_gossip !
  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    puts "Il reste un truc là dedans ? : #{params["gossip_author"]} Oui !"
    puts "Et là dedans ? : #{params["gossip_content"]} Oui aussi !"
    puts "Oh mais enfait je suis dans le terminal là ! Personne peut me voir ?!"
    redirect '/'
  end

  get '/gossips/:id' do
    erb :show, locals: {gossip: Gossip.find(params["id"])}
  end

  get '/gossips/:id/edit/' do
    erb :edit, locals: {id: params["id"]}
  end

  post '/gossips/:id/edit/' do
    Gossip.update(params["id"], params["gossip_author"], params["gossip_content"])
    redirect '/'
  end
end


