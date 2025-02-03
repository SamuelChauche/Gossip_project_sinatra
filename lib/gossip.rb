class Gossip
  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open("db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.find(id)
    gossips = []
    CSV.foreach("db/gossip.csv") do |row|
      gossips << Gossip.new(row[0], row[1])
    end
    gossips[id.to_i - 1]
  end

  def self.all
    gossips = []
    CSV.foreach("db/gossip.csv") do |row|
      gossips << Gossip.new(row[0], row[1])
    end
    gossips
  end

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
