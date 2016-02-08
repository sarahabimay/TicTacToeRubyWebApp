require "tictactoe/player"

class WebHumanPlayer
  include Player

  attr_reader :display

  def initialize(mark, display)
    @mark = mark
    @display = display
    @move = 0
  end

  def set_new_move(position)
    @move = position
  end

  def get_next_move(board)
    next_move = 0
    if is_ready?
      next_move = display.get_next_move
    end
    next_move
  end

  def is_ready?
    display.has_new_move?
  end

  def has_new_move?
    move != 0 
  end

  private

  attr_accessor :mark, :move
end
