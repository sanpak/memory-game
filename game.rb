class PositionError < StandardError
end

class FaceDownError < StandardError
end

class Game
  attr_accessor :board
  def initialize
    @board = Board.new
    @board.populate
  end

  def play
    until won?
      prompt
      system("clear")
      @board.render
      sleep(3)
      system("clear")
      sleep(1)
      @board.hide_all
      @board.render
    end
    puts "Congralution!"
  end

  def prompt
    begin
      puts "First card you want to flip?"
      move1 = gets.chomp.split(",").map { |el| el.to_i }
      valid_move?(move1)
    rescue FaceDownError
      puts "The Card is faced up"
      retry
    rescue PositionError
      puts "Beyond border"
      retry
    end
    @board[move1].display = @board[move1].reveal
    @board[move1].face_down = false

    begin
      puts "Second card you want to flip?"
      move2 = gets.chomp.split(",").map { |el| el.to_i }
      valid_move?(move2)
    rescue FaceDownError
      puts "The Card is faced up"
      retry
    rescue PositionError
      puts "Beyond border"
      retry
    end
    @board[move2].display = @board[move2].reveal
    @board[move2].face_down = false

    receive_match(move1,move2) if @board[move1].display == @board[move2].display

    # if match?(move1,move2)
    #   receive_match(move1,move2)
    # else
    #   not_match(move1,move2)
    # end
  end

  def won?
    board.board.all? { |row| row.all? { |el| el.display == :O } }
  end

  def receive_match(move1,move2)
    @board[move1].display = :O
    @board[move2].display = :O
    @board[move1].face_down = false
    @board[move2].face_down = false
  end

  def not_match(move1,move2)
    @board[move1].display = @board[move1].hide
    @board[move2].display = @board[move2].hide
  end

  def match?(pos1,pos2)
    @board[pos1].face_value == @board[pos2].face_value
  end

  def valid_move?(pos)
    raise PositionError if pos.any? { |el| el > 4 || el < 0 }
    raise FaceDownError if @board[pos].face_down != true
  end

  def rescue_a_move(move)
    begin
      valid_move?(move)
    rescue FaceDownError
      puts "The Card is faced up"
    rescue PositionError
      puts "Beyond border"
    end
  end

end
