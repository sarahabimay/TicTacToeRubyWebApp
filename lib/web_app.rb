require "erb"
require "tictactoe/board_options"
require "tictactoe/game_type_options"
require "tictactoe/game"
require "game_controller"
require "game_options_display"
require "game_layout_display"

class WebApp 
  attr_reader :controller

  def initialize(controller, display)
    @controller = controller
    @display = display
  end

  def app_router
    controller = @controller
    display = @display
    Rack::Builder.new do |env|
      use Rack::Static, :urls  => ['/css'], :root => 'lib/assets'
      
      map "/" do
        run(Proc.new do |env|
          [200, {}, [GameOptionsDisplay.new.render_page]]
        end)
      end

      map "/game" do
        map "/create" do
          run(Proc.new do |env|
            game_layout = GameLayoutDisplay.new(Rack::Request.new(env).params)
            controller.create_game(game_layout.dimension, game_layout.game_type, display)
            template = game_layout.render_template
            [200, {}, [template.result(controller.get_binding())]]
          end)
        end

        map "/play" do
          run(Proc.new do |env|
            params = Rack::Request.new(env).params
            controller.play_move_in_position(params["position"])
            game_layout = GameLayoutDisplay.new(params)
            template = game_layout.render_template
            [200, {}, [template.result(controller.get_binding())]]
          end)
        end
      end
    end.to_app
  end

  private 

  attr_reader :display
end
