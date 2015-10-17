shared_context 'game state', a: :b do
  let(:joe) { FactoryGirl.create(:player_joe) }
  let(:slack_request) { double(Game::SlackRequest) }
  let(:slack_messenger) { double(Game::SlackMessenger) }
  let(:game) { double(Game::Game) }
  let(:game_command) { Command::GameCommand.new(game) }
  
  let(:inventory) { FactoryGirl.create(:inventory_with_items) }
  let(:inventory_two) { FactoryGirl.create(:inventory_with_more_items) }

  let(:player) { FactoryGirl.create(:player, name: "josh skeen", inventory: inventory)}
  let(:room) { FactoryGirl.create(:room, players: [player]) }

  before(:each) do
    allow(game).to receive(:slack_request).and_return(slack_request)
    allow(game).to receive(:player).and_return(player)
    allow(game).to receive(:room).and_return(room)
    allow(game).to receive(:slack_messenger).and_return(slack_messenger)
  end
end
