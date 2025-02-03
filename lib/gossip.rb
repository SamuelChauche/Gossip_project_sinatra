class Gossip
  attr_accessor :author, :content

  # La méthode initialize est appelée lorsque tu crées une nouvelle instance de la classe Gossip.
  # Elle prend deux paramètres : author (l'auteur du potin) et content (le contenu du potin).
  # Ces paramètres sont assignés aux variables d'instance @author et @content.
  def initialize(author, content)
    @author = author
    @content = content
  end

  # La méthode save est utilisée pour enregistrer un potin dans un fichier CSV.
  # Elle ouvre le fichier CSV en mode "append" (ajout) et ajoute une nouvelle ligne avec l'auteur et le contenu du potin.
  def save
    CSV.open("db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  # La méthode find est une méthode de classe (self) qui permet de trouver un potin spécifique en fonction de son ID.
  # Elle lit tous les potins du fichier CSV et les stocke dans un tableau.
  # Ensuite, elle retourne le potin correspondant à l'ID donné.
  def self.find(id)
    gossips = []
    CSV.foreach("db/gossip.csv") do |row|
      gossips << Gossip.new(row[0], row[1])
    end
    gossips[id.to_i - 1]
  end
  # La ligne gossips[id.to_i - 1] est utilisée pour accéder à un potin spécifique dans le tableau gossips.
  # 1. id.to_i : La méthode to_i convertit la valeur de id (qui est une chaîne de caractères) en un entier (integer).
  # 2. id.to_i - 1 : On soustrait 1 de l'entier obtenu. Cela est nécessaire car les IDs commencent à 1,
  #    mais les indices des tableaux en Ruby commencent à 0. Par exemple, si id est 3, id.to_i - 1 sera 2.
  # 3. gossips[id.to_i - 1] : On utilise l'indice calculé pour accéder à l'élément correspondant dans le tableau gossips.
  #    Par exemple, si id est 3, gossips[2] retournera le troisième potin dans le tableau.


  # La méthode all est une méthode de classe (self) qui récupère tous les potins du fichier CSV.
  # Elle lit chaque ligne du fichier CSV et crée une nouvelle instance de Gossip pour chaque ligne.
  # Ensuite, elle retourne un tableau contenant tous les potins.
  def self.all
    gossips = []
    CSV.foreach("db/gossip.csv") do |row|
      gossips << Gossip.new(row[0], row[1])
    end
    gossips
  end
  # La ligne gossips << Gossip.new(row[0], row[1]) est utilisée pour ajouter un nouveau potin au tableau gossips.
  # 1. row[0], row[1] : row est une ligne du fichier CSV, qui est un tableau contenant les valeurs de la ligne.
  #    row[0] est la première valeur de la ligne (l'auteur du potin), et row[1] est la deuxième valeur de la ligne (le contenu du potin).
  # 2. Gossip.new(row[0], row[1]) : On crée une nouvelle instance de la classe Gossip en passant l'auteur et le contenu
  #    comme arguments au constructeur (la méthode initialize). Cela crée un nouvel objet Gossip avec les valeurs de row[0] et row[1].
  # 3. gossips << Gossip.new(row[0], row[1]) : L'opérateur << (shovel operator) est utilisé pour ajouter le nouvel objet Gossip
  #    à la fin du tableau gossips. Cela signifie que chaque ligne du fichier CSV est convertie en un objet Gossip et ajoutée au tableau.



  # La méthode update est une méthode de classe (self) qui met à jour un potin spécifique dans le fichier CSV.
  # Elle lit tous les potins du fichier CSV et les stocke dans un tableau.
  # Ensuite, elle met à jour le potin correspondant à l'ID donné avec les nouvelles valeurs d'auteur et de contenu.
  # Enfin, elle réécrit le fichier CSV avec les potins mis à jour.
  def self.update(id, author, content)
    gossips = []
    CSV.foreach("db/gossip.csv") do |row|
      gossips << row
    end
    gossips[id.to_i - 1] = [author, content]
    CSV.open("db/gossip.csv", "wb") do |csv|
      gossips.each do |gossip|
        csv << gossip
      end
    end
  end
end
# La ligne gossips[id.to_i - 1] = [author, content] est utilisée pour mettre à jour un potin spécifique dans le tableau gossips.
# 1. id.to_i : La méthode to_i convertit la valeur de id (qui est une chaîne de caractères) en un entier (integer).
#    Par exemple, si id est "3", id.to_i sera 3.
# 2. id.to_i - 1 : On soustrait 1 de l'entier obtenu. Cela est nécessaire car les IDs commencent à 1,
#    mais les indices des tableaux en Ruby commencent à 0. Par exemple, si id est 3, id.to_i - 1 sera 2.
# 3. gossips[id.to_i - 1] : On utilise l'indice calculé pour accéder à l'élément correspondant dans le tableau gossips.
#    Par exemple, si id est 3, gossips[2] accède au troisième potin dans le tableau.
# 4. [author, content] : On crée un tableau contenant les nouvelles valeurs d'auteur et de contenu pour le potin.
#    Par exemple, si author est "Nouvel Auteur" et content est "Nouveau Contenu", [author, content] sera ["Nouvel Auteur", "Nouveau Contenu"].
# 5. gossips[id.to_i - 1] = [author, content] : On assigne le nouveau tableau [author, content] à l'élément correspondant dans le tableau gossips.
#    Cela met à jour le potin spécifique avec les nouvelles valeurs d'auteur et de contenu.
