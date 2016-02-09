require "web_player_factory"
require "tictactoe/game_type_options"

RSpec.describe WebPlayerFactory do
  let(:hvh) { TicTacToe::GameTypeOptions::ID_TO_GAME_TYPE[1] }

  it "creates two WebHumans for HVH player type" do
    factory = WebPlayerFactory.new(WebDisplay.new)
    players = factory.get_players_for_game_type(hvh)
    expect(players[TicTacToe::Mark::X]).to be_instance_of(WebHumanPlayer)
    expect(players[TicTacToe::Mark::O]).to be_instance_of(WebHumanPlayer)
  end
end
