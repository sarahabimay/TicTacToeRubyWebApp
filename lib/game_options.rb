class GameOptions
  def initialize(dimensions, game_types)
    @dimensions = dimensions
    @game_types = game_types
  end

  def get_binding
    binding()
  end

  private
  
  attr_reader :dimensions, :game_types
end
