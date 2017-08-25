require 'rails_helper'

describe Room, vcr: true do

  let!(:josh){
    FactoryGirl.create(:player_josh)
  }
  let!(:invized_donny){
    FactoryGirl.create(:player_invized_bob)
  }
  let!(:joe){
    FactoryGirl.create(:player_joe)
  }

  describe "from valid slack id" do
    let(:slackid){
      "C03RCDX1A"
    }
    it "creates a new room or looks up an existing one" do
      room = Room.find_or_create_by_slackid(slackid)
      expect(room.title).to eq "general"
      expect(room.slackid).to eq slackid
      expect(room.description).to include "team-wide communication"
      second_room_query = Room.find_or_create_by_slackid(slackid)
      expect(room.id).to eq second_room_query.id
    end

    it "assigns associated players if they exist" do
      room = Room.find_or_create_by_slackid(slackid)
      expect(room.players).to include joe
    end

  end

  describe "from invalid slack id" do
    it "creates a new room or looks up an existing one" do
      slackid = "POOKIE"
      room = Room.find_or_create_by_slackid(slackid)
      expect(room.title).to eq I18n.t 'room.generic_title'
      expect(room.slackid).to eq slackid
      expect(room.description).to eq I18n.t 'room.generic_description'
    end
  end

  describe "players" do
    let(:room){
      FactoryGirl.create(:room, players: [josh, joe])
    }
    it "finds a player by name if present" do
      expect(room.player_by_name("josh")).to eq josh
      expect(room.player_by_name("randy")).to eq nil
      expect(room.player_by_name("joe")).to eq joe
    end
    describe "which is invized" do
      let(:room) {
        FactoryGirl.create(:room, players: [invized_donny])
      }
      it 'finds a player only if they are not invisible' do
        expect(room.player_by_name("donny")).to eq nil
        invized_donny.effects.delete_all
        expect(room.player_by_name("donny")).to eq invized_donny
      end
    end
  end

end
