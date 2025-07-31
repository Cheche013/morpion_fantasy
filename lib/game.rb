require_relative 'player'
require_relative 'board'
require_relative 'board_case'
require 'pastel'
pastel = Pastel.new


# Nettoyage tableau

def clear_screen
  system("clear") || system("cls")
end


clear_screen
puts pastel.bold.magenta(" Bienvenue dans MORPION FANTASY : ") +
     pastel.underline.yellow("Elfes vs Orcs") 
puts "-" * 50

# Création des joueurs
print "Joueur 1, entre ton prénom : "
name1 = gets.chomp.capitalize
player1 = Player.new(name1, "Elfe", "X")

print "Joueur 2, entre ton prénom : "
name2 = gets.chomp.capitalize
player2 = Player.new(name2, "Orc", "O")

puts "\nVoici les combattants :"
puts "#{player1.name} rejoint les Elfes avec le symbole #{player1.symbol}"
puts "#{player2.name} rejoint les Orcs avec le symbole #{player2.symbol}"

players = [player1, player2]

# Boucle principale du jeu
loop do
  board = Board.new
  turn_count = 0
  winner = nil

  # Boucle tour par tour jusqu'à Win ou Egal
  loop do
    current_player = players[turn_count % 2]
    clear_screen
    puts "Tour #{turn_count + 1} - C'est au tour de #{current_player.name} (#{current_player.faction})"
    board.display

    print "\nChoisis une case : "
    pos = gets.chomp.upcase

    until board.play_turn(pos, current_player.symbol)
      puts pastel.italic.blue("Aîîîe.. Position invalide ou déjà prise. Essaie encore :")
      print "> "
      pos = gets.chomp.upcase
    end

    #WIN 
    if board.victory?(current_player.symbol)
      clear_screen
      board.display
      puts pastel.underline.yellow( "\n WIN !!! #{current_player.name} des #{current_player.faction}s a remporté la bataille !!! ")
      winner = current_player
      break
    end

    # Egal
    turn_count += 1
    if turn_count == 9
      clear_screen
      board.display
      puts pastel.underline.cyan( "\n Match nul ! Les runes sont silencieuse aujourd'hui...")
      break
    end
  end

  # --- Relancer une partie ? ---
  puts pastel.bold.magenta( "\nSouhaitez-vous rejouer une partie noble Créature ? (o/n)")
  print "> "
  answer = gets.chomp.downcase
  break unless answer == "o"
end

# --- Fin du jeu ---
puts pastel.bold.magenta( "\n Merci d'avoir joué à Morpion Fantasy ! À bientôt, noble Créature.")
