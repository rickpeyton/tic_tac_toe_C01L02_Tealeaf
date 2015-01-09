# Tic Tac Toe Assignment
# Tealeaf Academy: C01L02
require 'pry'
class Board
  attr_accessor :board

  def initialize
    draw_blank_game_board
  end

  def draw_blank_game_board
    system 'clear'
    board = {}
    ('1'..'9').each { |position| board[position] = ' ' }
    draw_board(board)
  end

  def draw_board(board)
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
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class Human < Player
  def turn
    puts "#{name}: Choose a position (from 1 to 9):"
  end
end

class Computer < Player
  def turn
    puts "#{name} chooses an empty position..."
  end
end

class TicTacToe
  attr_accessor :board, :player, :computer

  def initialize
    @board = Board.new
    @player = Human.new('Rick')
    @computer = Computer.new('Johnny 5')
    play
  end

  def play
    play_until_someone_wins
    draw_blank_game_board if play_again?
  end

  def play_until_someone_wins
    begin
      player.turn
      redraw_game_board
      did_player_win?
      computer_choose_a_position
      redraw_game_board
      did_computer_win?
    end until there_is_a_winner
  end

  def play_again?
    puts 'Do you want to play again? (y/n)'
    true if gets.chomp.downcase == 'y'
  end
end
