require "tictactoe/game"
require "tictactoe/board"
require "web_player_factory"

class GameController
  attr_reader :display, :board, :players, :game_type, :game_type_description

  def initialize(player_factory)
    @player_factory = player_factory
  end

  def create_game(dimension, game_type, display)
    @display = display
    @game_type = game_type
    @game_type_description = TicTacToe::GameTypeOptions.lookup_game_type_for_id(@game_type)
    @board = TicTacToe::Board.new(dimension)
    display.display_board(board)
    @players = player_factory.get_players_for_game_type(game_type)
    @game = TicTacToe::Game.new(board, game_type, display, players) 
  end

  def play_move_in_position(position)
    display.next_player_move(position)
    @game.play_turns
    @board = display.board
  end

  def get_binding
    binding()
  end

  private

  attr_reader :player_factory, :game
end
