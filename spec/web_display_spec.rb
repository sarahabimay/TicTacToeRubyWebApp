require "web_display"
require "tictactoe/board"
require "tictactoe/board_options"

RSpec.describe WebDisplay do
  let(:display) { WebDisplay.new }

  it "receives message to display_board and stores it" do
    display.display_board(TicTacToe::Board.new(TicTacToe::BoardOptions::DIMENSIONS["THREE_BY_THREE"]))
    expect(display.board).to be_instance_of(TicTacToe::Board)
  end

  it "creates winning announcement for a mark" do
    display.winning_announcement(TicTacToe::Mark::X)
    expect(display.results_message).to eq("Player X is the Winner!")
  end

  it "confirms it has a new move" do
    display.next_player_move(1)
    expect(display.has_new_move?).to eq(true)
  end

  it "receives next user move" do
    display.next_player_move(1)
    expect(display.get_next_move).to eq(1)
  end
end

