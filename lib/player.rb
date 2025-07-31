class Player
attr_accessor :name, :faction, :symbol

    def initialize(name, faction, symbol)
        @name = name
        @faction = faction
        @symbol = symbol 
    end
end