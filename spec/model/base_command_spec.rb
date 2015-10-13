require 'rails_helper'
require 'game'
require 'slack_request'

describe 'Game Command' do

  let(:game){ double(Game) }
  let(:game_command){ GameCommand.new(game) }
  let(:slack_request){ double(SlackRequest) }

  describe "Text Processing" do
    before(:each){
      allow(game).to receive(:slack_request).and_return(slack_request)
      allow(slack_request).to receive(:text).and_return("give 2 obsidian dagger josh")
    }

    it "extracts a quantity" do
      expect(game_command.quantity).to eq 2
    end

    it "determines a target" do
    expect(game_command.target).to eq "josh"
    end

    it "extracts a command" do
      expect(game_command.command).to eq "give"
    end

    it "extracts a command" do
      expect(game_command.arguments).to eq "obsidian dagger"
    end
  end

end
