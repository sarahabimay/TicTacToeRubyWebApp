class GameOptionsDisplay
  def initialize()
    @dimensions = TicTacToe::BoardOptions::DIMENSIONS
    @game_types = TicTacToe::GameTypeOptions::GAME_OPTIONS
  end

  def render_page
    template = render_template
    template.result(binding())
  end

  def get_binding
    binding()
  end

  private

  def render_template
    path = File.expand_path("view/index_options_page.erb")
    file = File.read(path)
    ERB.new(file)
  end

  attr_reader :dimensions, :game_types
end
