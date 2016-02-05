require "rack/test"
require "web_app"
require "pry-byebug"

RSpec.describe WebApp do
  include Rack::Test::Methods

  def app
    described_class.new.app_router
  end

  context "/ is options page" do 
    it "gets status ok for landing page" do
      get "/"
      #expect(last_request.url).to eq("/")
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
end
