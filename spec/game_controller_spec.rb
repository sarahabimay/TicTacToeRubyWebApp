require "tictactoe/board"
require "tictactoe/board_options"
require "tictactoe/game_type_options"
require "web_player_factory"
require "game_controller"

RSpec.describe GameController do
  let(:hvh_option) { 1 }
  let(:hvh) { TicTacToe::GameTypeOptions::ID_TO_GAME_TYPE[hvh_option] }
  let(:dimension) { TicTacToe::BoardOptions::DIMENSIONS["THREE_BY_THREE"] }
  let(:display_spy) { instance_spy(WebDisplay) }
  let(:players) { Hash[TicTacToe::Mark::X, WebHumanPlayer.new(TicTacToe::Mark::X, display_spy), TicTacToe::Mark::O, WebHumanPlayer.new(TicTacToe::Mark::O, display_spy)] }
  let(:player_factory_spy) { instance_spy(WebPlayerFactory) }

  it "creates a new hvh, 3x3 game" do
    expect(player_factory_spy).to receive(:get_players_for_game_type).with(hvh_option).and_return(players)
    game_controller = GameController.new(player_factory_spy)
    game_controller.create_game(dimension, hvh_option, display_spy)
    expect(game_controller.game_type).to be(hvh_option)
    expect(game_controller.board.board_size).to be(dimension*dimension)
  end

  it "plays a move" do
    expect(display_spy).to receive(:next_player_move).with(1) 
    expect(display_spy).to receive(:get_next_move).and_return(1) 
    expect(display_spy).to receive(:has_new_move?).and_return(true, true, false) 
    expect(display_spy).to receive(:display_board)
    expect(player_factory_spy).to receive(:get_players_for_game_type).with(hvh_option).and_return(players)

    game_controller = GameController.new(player_factory_spy)
    game = game_controller.create_game(dimension, hvh_option, display_spy)
    game_controller.play_move_in_position(1)
    expect(game_controller.game_type).to be(hvh_option)
    expect(game.board.find_mark_in_position(1)).to be(TicTacToe::Mark::X)
  end
end
