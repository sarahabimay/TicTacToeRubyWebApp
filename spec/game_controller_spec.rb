require "tictactoe/board"
require "tictactoe/board_options"
require "tictactoe/game_type_options"
require "web_player_factory"
require "game_controller"

RSpec.describe GameController do
  let(:hvh_option) { 1 }
  let(:hvh) { TicTacToe::GameTypeOptions::ID_TO_GAME_TYPE[hvh_option] }
  let(:dimension) { TicTacToe::BoardOptions::DIMENSIONS["THREE_BY_THREE"] }
  let(:display) { WebDisplay.new }
  let(:players) { Hash[TicTacToe::Mark::X, WebHumanPlayer.new(TicTacToe::Mark::X, display), TicTacToe::Mark::O, WebHumanPlayer.new(TicTacToe::Mark::O, display)] }
  let(:player_factory_spy) { instance_spy(WebPlayerFactory) }

  it "creates a new hvh, 3x3 game" do
    expect(player_factory_spy).to receive(:get_players_for_game_type).with(hvh_option).and_return(players)
    game_controller = GameController.new(player_factory_spy)
    game_controller.create_game(dimension, hvh_option, display)
    expect(game_controller.game_type).to be(hvh_option)
    expect(game_controller.board.board_size).to be(dimension*dimension)
  end

  it "plays a move" do
    allow(player_factory_spy).to receive(:get_players_for_game_type).and_return(players)
    game_controller = GameController.new(player_factory_spy)
    game = game_controller.create_game(dimension, hvh_option, display)
    game_controller.play_move_in_position(1)
    expect(game.board.find_mark_in_position(1)).to be(TicTacToe::Mark::X)
  end

  it "tells display about winning game result" do
    player1_spy = instance_spy(WebHumanPlayer)
    player2_spy = instance_spy(WebHumanPlayer)
    players = Hash[TicTacToe::Mark::X, player1_spy, TicTacToe::Mark::O, player2_spy]
    allow(player1_spy).to receive(:get_next_move).and_return(1, 2, 3)
    allow(player2_spy).to receive(:get_next_move).and_return(4, 5)
    allow(player_factory_spy).to receive(:get_players_for_game_type).with(hvh_option).and_return(players)
    game_controller = GameController.new(player_factory_spy)
    game = game_controller.create_game(dimension, hvh_option, display)
    game_controller.play_move_in_position(1)
    expect(display.game_is_over).to eq(true)
    expect(display.result).to eq("Player #{TicTacToe::Mark::X} is the Winner!")
  end
end
