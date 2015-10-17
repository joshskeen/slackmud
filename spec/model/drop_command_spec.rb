require 'rails_helper'

describe Command::DropCommand do
  include_context 'game state'
  it 'error cases' do
    allow(slack_request).to receive(:text).and_return('drop pimpcane')
    expect(game_command.perform).to eq "You don't have one of those to drop!"
    allow(slack_request).to receive(:text).and_return('drop 2 tunic')
    expect(game_command.perform).to eq "You don't have that many!"
  end

  it 'transfers an item from player to room' do
    allow(slack_request).to receive(:text).and_return('drop tunic')
    expect(slack_messenger).to receive(:msg_room).with(room.slackid, 'josh skeen drops a black woolen tunic on the floor. (1)')
    expect(game_command.perform).to eq 'Ok, you drop a black woolen tunic. (1)'
  end
end
