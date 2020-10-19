require 'gossip'

class ApplicationController < Sinatra::Base
  # Opération get sur la page '/' qui prend la requête du visiteur et l'envoie vers index.erb
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  # Opération get sur la page '/gossips/new/' qui prend la requête du visiteur et l'envoie vers new_gossip.erb
  get '/gossips/new/' do
    erb :new_gossip
  end

  # On créé une nouvelle gossip via le formulaire (post) de la page new_gossip !
  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    puts "Il reste un truc là dedans ? : '#{params["gossip_author"]}' Oui !"
    puts "Et là dedans ? : '#{params["gossip_content"]}' Oui aussi !"
    puts "Oh mais enfait je suis dans le terminal là ! Personne ne peut me voir !"
    redirect '/'
  end

  # Opération get sur la page '/gossips/:id/' (chemin dynamique) qui prend la requête du visiteur et l'envoie vers show.erb
  get '/gossips/:id' do
    erb :show, locals: {gossip: Gossip.find(params["id"])}
  end

  # Opération get sur la page '/gossips/:id/edit/' qui prend la requête du visiteur et l'envoie vers edit.erb (formulaire pour récupérer un post)
  get '/gossips/:id/edit/' do
    erb :edit, locals: {id: params["id"]}
  end

  # Exécute la fonction update pour modifier un gossip via les paramètres entrés par l'user (post) !
  post '/gossips/:id/edit/' do
    Gossip.update(params["id"], params["gossip_author"], params["gossip_content"])
    redirect '/'
  end
end


