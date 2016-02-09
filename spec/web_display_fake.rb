class WebDisplayFake

  attr_reader :board, :results_message, :next_move, :result
  attr_accessor :game_is_over

  def initialize
    @next_move = 0
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
    next_move != 0
  end

  def get_next_move
    move_to_be_returned = next_move
    @next_move = 0
    move_to_be_returned
  end

  def display_win(mark)
    @result = mark
  end

  def has_win?
    result == TicTacToe::Mark::X || result == TicTacToe::Mark::X
  end
  
  def result_announcement
    announcement = winning_announcement if has_win?
    announcement = draw_announcement if !has_win?
    announcement
  end

  private

  def winning_announcement
    @results_message = "Player #{get_result} is the Winner!"
  end

  def draw_announcement
    @results_message = "Game Over! The game is a Draw!"
  end

  def get_result
    result_to_return = result 
    result = ""
    result_to_return 
  end

  attr_writer :next_move, :result
end
