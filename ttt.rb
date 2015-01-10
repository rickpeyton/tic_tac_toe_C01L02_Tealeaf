# Tic Tac Toe Assignment
# Tealeaf Academy: C01L02
require 'pry'
class Board
  attr_accessor :board_moves

  def draw_blank_game_board
    self.board_moves = {}
    ('1'..'9').each { |position| self.board_moves[position] = ' ' }
    draw_board(board_moves)
  end

  def draw_board(board)
    system 'clear'
    puts ''
    puts '      |   |   '
    puts "    #{board['1']} | #{board['2']} | #{board['3']} "
    puts '      |   |   '
    puts '   ---+---+---'
    puts '      |   |   '
    puts "    #{board['4']} | #{board['5']} | #{board['6']} "
    puts '      |   |   '
    puts '   ---+---+---'
    puts '      |   |   '
    puts "    #{board['7']} | #{board['8']} | #{board['9']} "
    puts '      |   |   '
    puts ''
  end
end

class Player
  attr_accessor :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def valid_pick?(pick, board)
    true if board.board_moves[pick] == ' '
  end
end

class Human < Player
  def turn(board)
    begin
      puts "#{name}: Choose an empty position (from 1 to 9):"
      picked_position = gets.chomp
    end until ('1'..'9').include?(picked_position) &&
              valid_pick?(picked_position, board)
    picked_position
  end
end

class Computer < Player
  def turn(board)
    begin
      puts "#{name} chooses an empty position..."
      picked_position = board.board_moves.keys.sample
    end until valid_pick?(picked_position, board)
    picked_position
  end
end

class TicTacToe
  VICTORY_CONDITIONS = %w(123 456 789 147 258 369 159 357)

  attr_accessor :board, :player, :computer, :winner

  def initialize
    @board = Board.new
    @player = Human.new('Rick', 'X')
    @computer = Computer.new('Johnny 5', 'O')
    play
  end

  def play
    begin
      board.draw_blank_game_board
      self.winner = nil
      play_until_game_over
    end while play_again? == true
  end

  def play_until_game_over
    begin
      update_board(player.turn(board), player.symbol)
      game_over || update_board(computer.turn(board), computer.symbol)
    end until game_over
    display_results
  end

  def game_over
    true if there_is_a_winner || there_is_a_tie
  end

  def count_remaining_moves
    board.board_moves.values.count(' ')
  end

  def update_board(pick, letter)
    board.board_moves[pick] = letter
    board.draw_board(board.board_moves)
  end

  def play_again?
    puts 'Do you want to play again? (y/n)'
    true if gets.chomp.downcase == 'y'
  end

  def there_is_a_tie
    true if count_remaining_moves == 0
  end

  def there_is_a_winner
    true if is_there_a_winner?
  end

  def is_there_a_winner?
    if check_player?(player.symbol)
      true
    elsif check_player?(computer.symbol)
      true
    end
  end

  def check_player?(letter)
    VICTORY_CONDITIONS.each do |condition|
      victory_counter = 0
      board.board_moves.each do |k, v|
        victory_counter += 1 if condition.include?(k) && v == letter
      end
      if victory_counter == 3
        self.winner = letter
        return true
      end
    end
    false
  end

  def display_results
    if winner == player.symbol
      puts 'You win!'
    elsif winner == computer.symbol
      puts 'Computer wins!'
    else
      puts 'It is a tie...'
    end
  end
end

TicTacToe.new
