shared_context 'game state' do
  let(:slack_request) { double(SlackRequest) }
  let(:game) { double(Game) }
  let(:game_command) { GameCommand.new(game) }
  let(:slack_messenger) { double(SlackMessenger) }
  let(:player) { FactoryGirl.create(:player_with_inventory) }
  let(:bob) { FactoryGirl.create(:player, name: 'bob') }
  let(:room) { FactoryGirl.create(:room, players: [player, bob]) }

  before(:each) do
    allow(game).to receive(:slack_request).and_return(slack_request)
    allow(game).to receive(:player).and_return(player)
    allow(game).to receive(:room).and_return(room)
    allow(game).to receive(:slack_messenger).and_return(slack_messenger)
    allow(slack_request).to receive(:text).and_return(text)
  end
  let(:text) { '' }
end
