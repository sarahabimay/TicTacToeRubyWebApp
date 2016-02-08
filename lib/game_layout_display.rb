class GameLayoutDisplay
  attr_reader :game_type, :dimension

  def initialize(params)
    @dimension = TicTacToe::BoardOptions::DIMENSIONS[params["dimension"]] 
    @game_type = TicTacToe::GameTypeOptions::ID_TO_GAME_TYPE.key(params["game_type"]) 
  end

  def render_template
    path = File.expand_path("view/game_layout.erb")
    file = File.read(path)
    ERB.new(file)
  end
end
