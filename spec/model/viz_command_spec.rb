require 'rails_helper'

describe VizCommand do

  let(:game){ double(Game) }
  let(:game_command){ GameCommand.new(game) }
  let(:slack_request){ double(SlackRequest) }
  let(:slack_messenger){double(SlackMessenger)}
  let!(:effect_invized) { FactoryGirl.create(:effect_invized) }
  let(:room){ FactoryGirl.create(:room)}

  before(:each){
    allow(game).to receive(:slack_request).and_return(slack_request)
    allow(game).to receive(:room).and_return(room)
  }

  describe "success" do
    let(:player){ FactoryGirl.create(:player_with_inventory)}
    before(:each){
      allow(game).to receive(:player).and_return(player)
      allow(game).to receive(:slack_messenger).and_return(slack_messenger)
    }

    it "disallows vizing when already vized" do
      allow(slack_request).to receive(:text).and_return("viz")
      expect(game_command.perform).to eq "You're already visible!"
      expect(player.name).to eq 'josh skeen'
    end

    it "allows vizing when invisible" do
      allow(slack_request).to receive(:text).and_return("viz")
      player.effects << Effect.where(name: Effect::EFFECT_INVIZED)
      expect(slack_messenger).to receive(:msg_room).with("C03RCDX1A", "josh skeen fades into existence.")
      expect(game_command.perform).to eq "You fade back into existence."
      expect(player.name).to eq 'josh skeen'
    end

  end
end
