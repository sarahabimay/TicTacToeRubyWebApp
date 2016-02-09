require "web_human_player"

RSpec.describe WebHumanPlayer do
  let(:board_stub) { instance_double(TicTacToe::Board) }
  let(:display) { WebDisplay.new }
  let(:web_human) { WebHumanPlayer.new(:X, display) }

  it "doesn't currently have a move available" do
    expect(web_human.has_new_move?).to eq(false)
  end

  it "display doesn't have a new move" do
    expect(display).to receive(:has_new_move?).and_return(false)
    expect(web_human.is_ready?).to eq(false)
  end

  it "is ready with a new move" do
    display.next_player_move(1)
    expect(web_human.is_ready?).to eq(true)
  end

  it "gets next move from display" do
    display.next_player_move(1)
    expect(web_human.get_next_move(board_stub)).to eq(1)
  end
end
