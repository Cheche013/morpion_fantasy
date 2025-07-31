require_relative 'board_case'
require 'pastel'  

class Board
  attr_accessor :cases

  def initialize
    @cases = {}
    @pastel = Pastel.new 

    ["A", "B", "C"].each do |row|
      ["1", "2", "3"].each do |col|
        pos = row + col
        @cases[pos] = BoardCase.new(pos)
      end
    end
  end
  
  def display
    puts
    puts "     1   2   3"
    puts "   +---+---+---+"
    ["A", "B", "C"].each do |row|
      print " #{row} |"
      ["1", "2", "3"].each do |col|
        pos = row + col
        case @cases[pos].value
        when "X"
          print " #{@pastel.green("X")} |"
        when "O"
          print " #{@pastel.red("O")} |"
        else
          print "   |"
        end
      end
      puts "\n   +---+---+---+"
    end
  end
  

  def play_turn(position, symbol)
    if @cases[position] && @cases[position].value == " "
      @cases[position].value = symbol
      true
    else
      false
    end
  end

    def victory?(symbol)
        win_combos = [
        ["A1", "A2", "A3"], ["B1", "B2", "B3"], ["C1", "C2", "C3"], # lignes
        ["A1", "B1", "C1"], ["A2", "B2", "C2"], ["A3", "B3", "C3"], # colonnes
        ["A1", "B2", "C3"], ["A3", "B2", "C1"]                      # diagonales
        ]

        win_combos.any? do |combo|
        combo.all? { |pos| @cases[pos].value == symbol }
        end
    end
end
