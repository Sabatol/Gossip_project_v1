require 'csv'

class Gossip
  attr_accessor :author, :content
  # Initialise un objet de classe Gossip avec deux variables de classe
  def initialize(author, content)
    @author = author
    @content = content
  end

  # Sauvegarde un gossip dans la bdd via ses deux variables
  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  # Ouvre la bdd et retourne un array de toutes les gossips
  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
      return all_gossips
  end

  # Ouvre la bdd et retourne la box de l'array de gossip correspondant à la recherche
  def self.find(id)
    all[id.to_i]
  end

  # Update une ligne en 3 étapes :
  def self.update(id, author, content)
    # Retourne le contenu de la bdd dans un array
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    
    # Modifie le contenu d'une box de cet array
    all_gossips[id.to_i].author = author
    all_gossips[id.to_i].content = content

    # Remplace le contenu de la bdd par l'array en question
    CSV.open("./db/gossip.csv", "w") do |csv_line|
      all_gossips.each do |gossip|
      csv_line << [gossip.author, gossip.content]
      end
    end
  end
end