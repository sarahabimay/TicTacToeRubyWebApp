class WebDisplay
  attr_reader :board, :results_message, :next_move, :result
  attr_accessor :game_is_over
  NO_MOVE_AVAILABLE = -1

  def initialize
    @next_move = NO_MOVE_AVAILABLE 
    @game_is_over = false
    @result = ""
  end

  def display_board(board)
    @board = board
  end

  def next_player_move(move)
    @next_move = move.to_i 
  end

  def has_new_move?
    next_move != NO_MOVE_AVAILABLE 
  end

  def get_next_move
    move_to_be_returned = next_move
    @next_move = NO_MOVE_AVAILABLE 
    move_to_be_returned
  end

  def display_win(mark)
    @result = result_announcement(mark) 
  end

  def result_announcement(mark)
    if TicTacToe::Mark::is_a_mark?(mark)
      announcement = winning_announcement(mark)
    else
      announcement = draw_announcement
    end
    announcement
  end

  private

  def winning_announcement(mark)
    @results_message = "Player #{mark} is the Winner!"
  end

  def draw_announcement
    @results_message = "Game Over! The game is a Draw!"
  end

  attr_writer :next_move, :result
end
