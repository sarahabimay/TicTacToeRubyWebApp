class WebDisplay

  attr_reader :board, :results_message, :next_move

  def initialize
    @next_move = 0
  end

  def display_board(board)
    @board = board
  end

  def next_player_move(move)
    @next_move = move.to_i 
  end

  def has_new_move?
    next_move != 0
  end

  def get_next_move
    move_to_be_returned = next_move
    @next_move = 0
    move_to_be_returned
  end

  def winning_announcement(mark)
    @results_message = "Player #{mark} is the Winner!"
  end

  private

  attr_writer :next_move
end
