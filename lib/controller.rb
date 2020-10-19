require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    puts "Il reste un truc là dedans ? : #{params["gossip_author"]} Oui !"
    puts "Et là dedans ? : #{params["gossip_content"]} Oui aussi !"
    puts "Oh mais enfait je suis dans le terminal là ! Personne peut me voir ?!"
    redirect '/'
  end

  get '/gossips/:id' do
    
    puts "Voici le numéro du potin que tu veux ! #{params['id']}!"
  end
end


