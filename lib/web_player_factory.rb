require "tictactoe/game_type_options"
require "web_human_player"

class WebPlayerFactory
  HVH = "HVH"
  def initialize(display)
    @display = display
    @players = []
  end

  def get_players_for_game_type(game_type)
    case TicTacToe::GameTypeOptions.lookup_game_type_for_id(game_type)
    when TicTacToe::GameTypeOptions::ID_TO_GAME_TYPE[HVH]
      players = Hash[TicTacToe::Mark::X, WebHumanPlayer.new(TicTacToe::Mark::X, display), TicTacToe::Mark::O, WebHumanPlayer.new(TicTacToe::Mark::O, display)]
    else
      players = Hash[TicTacToe::Mark::X, WebHumanPlayer.new(TicTacToe::Mark::X, display), TicTacToe::Mark::O, WebHumanPlayer.new(TicTacToe::Mark::O, display)]
    end
    players
  end

  private

  attr_reader :display, :players
end
