class TicTacToe
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6], 
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  def initialize
    @board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(str)
    str.to_i-1
  end

  def move(i, token = "X")
    @board[i] = token
  end

  def position_taken?(i)
    @board[i] == " " ? false : true
  end

  def valid_move?(i)
    position_taken?(i) || !i.between?(0, 8) ? false : true
  end

  def turn_count
    9 - @board.filter {|i| i== " "}.length
  end

  def current_player
    turn_count.odd? ? "O" : "X"
  end

  def turn
    puts "Please select a tile by entering a number, 1-9 (tiles ordered from top to bottom, left to right)"
    self.display_board
    tile = gets
    i = self.input_to_index(tile)
    if self.valid_move?(i)
      self.move(i, self.current_player)
    else 
      puts "Error! Invald move!"
      self.turn
    end
  end

  def won?
    WIN_COMBINATIONS.each do |i| 
      board_state = [@board[i[0]], @board[i[1]], @board[i[2]]]
      if !board_state.include?(" ") && board_state.uniq.length == 1
        return i
      end
    end
    false
  end

  def full?
    @board.include?(" ") ? false : true
  end

  def draw?
    self.full? && !self.won?
  end

  def over?
    self.won? || self.draw? ? true : false
  end

  def winner
    if self.over? && !self.draw? 
      return self.current_player == "X" ? "O" : "X"
    end
    nil
  end

  def play
    until self.over?
      self.turn
    end
    if self.winner
      puts "Congratulations #{self.winner}!"
    else 
      puts "Cat's Game!"
    end
  end
end