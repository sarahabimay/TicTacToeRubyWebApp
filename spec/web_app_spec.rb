require "rack/test"
require "web_app"
require "web_display"

RSpec.describe WebApp do
  include Rack::Test::Methods
  let(:display) { WebDisplay.new }
  let(:web_app) { described_class.new(GameController.new(WebPlayerFactory.new(display)), display) }

  def app
    web_app.app_router
  end

  context "/ is options page" do 
    it "gets status ok for landing page" do
      get "/"
      expect(last_response).to be_ok
    end

    it "gets title: 'Tic Tac Toe Game'" do
      get "/"
      expect(last_response.body).to include("Tic Tac Toe Game")
    end

    it "see game options are pre-set as 3x3 and HVH" do
      get "/"
      expect(last_response.body).to include("Game Type")
      expect(last_response.body).to include("HVH")
      expect(last_response.body).to include("Board Dimensions")
      expect(last_response.body).to include("THREE_BY_THREE")
    end
  end

  context "/game related" do
    it "HVH and 3x3 board created" do
      get "/game/create", { :dimension => "THREE_BY_THREE", :game_type => "HVH" }
      expect(last_response.body).to include("Tic Tac Toe Game: HVH")
      expect(last_response.body).to include("play?position=")
      expect(last_response.body).to include("GAME RESULTS:")
      expect(last_response.body).to include("Start Again?")
    end

    context "/play related" do
      before :each do
        expected_board_state = TicTacToe::Board.new(3, [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]])
        get "/game/create", { :dimension => "THREE_BY_THREE", :game_type => "HVH" }
      end

      it "/play?position=" do
        get "/game/play", { :position => "1" }

        expect(last_response).to be_ok
        expect(last_response.body).to include("X")
      end
    end
  end
end
