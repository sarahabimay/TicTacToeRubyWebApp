require "erb"
require "tictactoe/board_options"
require "tictactoe/game_type_options"
require "game_options"

class WebApp 
  def app_router
    Rack::Builder.new do |env|
      map "/" do
        run(Proc.new do |env|
          path = File.expand_path("view/index_options_page.erb")
          file = File.read(path)
          rendered = ERB.new(file)
          dimensions = TicTacToe::BoardOptions.constants
          game_types = TicTacToe::GameTypeOptions.constants
          game_options = GameOptions.new(dimensions, game_types)
          [200, {}, [rendered.result(game_options.get_binding)]]
        end)
      end
    end.to_app
  end
end
