# frozen_string_literal: true

class TicTacToe # rubocop:disable Style/Documentation
  attr_accessor :current_player, :board

  def initialize
    @board = Array.new(3) { Array.new(3, nil) }
    @current_player = 'X'
  end

  def make_move(row, column)
    @board[row][column] = @current_player
    shift_player
    display_board
  end

  def valid_move?(row, column)
    (0..2).include?(row) && (0..2).include?(column) && @board[row][column].nil?
  end

  def shift_player
    @current_player = @current_player == 'X' ? 'O' : 'X'
  end

  def draw?
    @board.flatten.all? { |item| !item.nil? } && !winner?
  end

  def winning_combinations
    rows = @board
    columns = @board.transpose
    diagonals = [[@board[0][0], @board[1][1], @board[2][2]], [@board[2][0], @board[1][1], @board[0][2]]]
    rows + columns + diagonals
  end

  def winner?
    winner_combination = winning_combinations.find do |combination|
      combination.flatten.uniq.length == 1 && combination.flatten.count == 3
    end
    if winner_combination.nil?
      nil
    else
      winner_combination.flatten.first
    end
  end

  def game_over?
    draw? || winner?
  end

  def display_board
    @board.each do |row|
      p row.join(' | ')
    end
  end
end

class Game # rubocop:disable Style/Documentation
  def initialize
    @game = TicTacToe.new
  end

  def play # rubocop:disable Metrics/MethodLength
    until @game.game_over?
      puts 'Enter the row and column where you"ll place your mark'
      row = gets.chomp.to_i
      column = gets.chomp.to_i

      if @game.valid_move?(row, column)
        @game.make_move(row, column)
      else
        puts 'please enter the correct row and column again'
      end
    end
    if @game.draw?
      puts 'Game is draw!!'
    else
      puts "The winner of the nought and crosses is: #{@game.winner?}"
    end
  end
end

game = Game.new
game.play
