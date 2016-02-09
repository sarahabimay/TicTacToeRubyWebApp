require "web_player_factory"
require "tictactoe/game_type_options"

RSpec.describe WebPlayerFactory do
  let(:hvh_option) { TicTacToe::GameTypeOptions::ID_TO_GAME_TYPE.key("HVH") }
  let(:invalid_option) { "9" }

  let(:hvh) { TicTacToe::GameTypeOptions::ID_TO_GAME_TYPE[hvh_option] }
  let(:factory) { WebPlayerFactory.new(WebDisplay.new) }

  it "creates two WebHumans for HVH player type" do
    players = factory.get_players_for_game_type(hvh)
    expect(players[TicTacToe::Mark::X]).to be_instance_of(WebHumanPlayer)
    expect(players[TicTacToe::Mark::O]).to be_instance_of(WebHumanPlayer)
  end

  it "creates WebHuman v WebHuman for unknown player type" do
    factory = WebPlayerFactory.new(WebDisplay.new)
    players = factory.get_players_for_game_type(invalid_option)
    expect(players[TicTacToe::Mark::X]).to be_instance_of(WebHumanPlayer)
    expect(players[TicTacToe::Mark::O]).to be_instance_of(WebHumanPlayer)
  end
end
