require "web_display"
require "tictactoe/board"
require "tictactoe/board_options"

RSpec.describe WebDisplay do
  let(:display) { WebDisplay.new }

  it "receives message to display_board and stores it" do
    display.display_board(TicTacToe::Board.new(TicTacToe::BoardOptions::DIMENSIONS["THREE_BY_THREE"]))
    expect(display.board).to be_instance_of(TicTacToe::Board)
  end

  it "confirms it has a new move" do
    display.next_player_move(1)
    expect(display.has_new_move?).to eq(true)
  end

  it "receives next user move" do
    display.next_player_move(1)
    expect(display.get_next_move).to eq(1)
  end

  it "receives winning mark" do
    display.game_is_over=(true)
    display.display_win(TicTacToe::Mark::X)
    expect(display.result).to eq("Player #{TicTacToe::Mark::X} is the Winner!")
  end
  
  it "displays draw announcement" do
    display.game_is_over=(true)
    display.display_win("")
    expect(display.result).to eq("Game Over! The game is a Draw!")
  end
end

