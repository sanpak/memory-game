require_relative 'card'

class Board
  attr_accessor :card_array, :board
  def initialize
    @card_array = []
    @board = Array.new(4) { Array.new(4) }
    create_cards.shuffle!
  end

  def create_cards
    2.times do
      (@board.size * 2).times do |i|
        card = Card.new(i)
        @card_array << card
      end
    end
    @card_array
  end

  def populate
    @board.each do |row|
      row.each_with_index do |el,idx|
        row[idx] = @card_array.pop unless @card_array.empty?
      end
    end
  end

  def [](pos)
    x,y = pos[0],pos[1]
    @board[x][y]
  end

  def []=(pos,value)
    x,y = pos[0],pos[1]
    @board[x][y] = value
  end

  # def play
  #   populate
  # end

  def render
    @board.each do |row|
      row.each do |el|
          print "#{el.display}   "
      end
      print "\n"
    end; nil

  end

  def hide_all
    @board.each do |row|
      row.each do |el|
        if el.display.class == Fixnum
          el.display = :X
          el.face_down = true
        end
      end
    end
  end

end
