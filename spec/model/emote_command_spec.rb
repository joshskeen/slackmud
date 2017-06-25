require 'rails_helper'

describe EmoteCommand do
  include_context 'game state'
  subject(:command) do
    EmoteCommand.new(game)
  end

  describe '#perform'
  context 'with no command found' do
    it 'returns emote not found command' do
      allow(slack_request).to receive(:text).and_return('emote bigdaddy')
      expect(slack_messenger).to_not receive(:msg_room)
      expect(game_command.perform).to eq "I don't know how to do that!"
    end
  end
  context 'dancing' do
    let(:emote) { 'dance' }
    context 'with no target' do
      it 'performs an emote' do
        allow(slack_request).to receive(:text).and_return("emote #{emote}")
        expect(slack_messenger).to receive(:msg_room).with(room.slackid, 'josh skeen dances wildly before you!')
        expect(game_command.perform).to eq "Feels silly, doesn't it?"
      end
    end

    context 'with a target' do
      context 'where target is not found' do
        it 'responds with a message indicating they are not found' do
          allow(slack_request).to receive(:text).and_return("emote #{emote} bigdaddy")
          expect(slack_messenger).to_not receive(:msg_room)
          expect(game_command.perform).to eq 'Eh, WHO?'
        end
      end
      context 'where target is in the room' do
        it 'performs an emote involving target as player' do
          allow(slack_request).to receive(:text).and_return("emote #{emote} bob")
          expect(slack_messenger).to receive(:msg_room).with(room.slackid, 'josh skeen sends bob across the dancefloor.')
          expect(game_command.perform).to eq 'You lead bob to the dancefloor.'
        end
      end

      context 'where target is current player' do
        it 'performs an emote involving target as player' do
          allow(slack_request).to receive(:text).and_return("emote #{emote} josh")
          expect(slack_messenger).to receive(:msg_room).with(room.slackid, 'josh skeen skips a light Fandango.')
          expect(game_command.perform).to eq 'You skip and dance around by yourself.'
        end
      end
    end
  end
  context 'cackling' do
    let(:emote) { 'cackle' }

    context 'self as target' do
      it 'performs an emote' do
        allow(slack_request).to receive(:text).and_return("emote #{emote} josh")
        expect(slack_messenger).to receive(:msg_room).with(room.slackid, 'josh skeen is really crazy now!  he cackles at himself.')
        expect(game_command.perform).to eq "You cackle at yourself.  Now, THAT'S strange!"
      end
    end

    context 'with no target' do
      it 'performs an emote' do
        allow(slack_request).to receive(:text).and_return("emote #{emote}")
        expect(slack_messenger).to receive(:msg_room).with(room.slackid, 'josh skeen throws back his head and cackles with insane glee!')
        expect(game_command.perform).to eq 'You cackle gleefully.'
      end
    end

  end
  context 'smirking' do
    let(:emote) { 'smirk' }
    context 'with no target' do
      it 'performs an emote' do
        allow(slack_request).to receive(:text).and_return("emote #{emote}")
        expect(slack_messenger).to receive(:msg_room).with(room.slackid, 'josh skeen smirks.')
        expect(game_command.perform).to eq 'You smirk.'
      end
    end

    context 'with a target' do
      context 'where target is not found' do
        it 'responds with a message indicating they are not found' do
          allow(slack_request).to receive(:text).and_return("emote #{emote} bigdaddy")
          expect(slack_messenger).to_not receive(:msg_room)
          expect(game_command.perform).to eq 'You want to smirk to whom?'
        end
      end
      context 'where target is in the room' do
        it 'performs an emote involving target as player' do
          allow(slack_request).to receive(:text).and_return("emote #{emote} bob")
          expect(slack_messenger).to receive(:msg_room).with(room.slackid, "josh skeen smirks at bob's saying.")
          expect(game_command.perform).to eq "You smirk at bob's saying."
        end
      end

      context 'where target is current player' do
        it 'performs an emote involving target as player' do
          allow(slack_request).to receive(:text).and_return("emote #{emote} josh")
          expect(slack_messenger).to receive(:msg_room).with(room.slackid, "josh skeen smirks at his own 'wisdom'.")
          expect(game_command.perform).to eq 'You smirk at yourself.  Okay.....'
        end
      end
    end
  end
end
