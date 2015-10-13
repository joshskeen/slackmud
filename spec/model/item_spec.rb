require 'rails_helper'

describe "Item" do

  let!(:item){FactoryGirl.create(:item)}
  let!(:inventory){
    FactoryGirl.create(:inventory_with_items)
  }

  describe 'search' do

    it "matches an item using its shortdesc" do
      searched_item = Item.first_by_keyword("obsidian")
      expect(searched_item.shortdesc).to eq item.shortdesc
      searched_item = Item.first_by_keyword("dagger")
      expect(searched_item.shortdesc).to eq item.shortdesc
      searched_item = Item.first_by_keyword("obsidian dagger")
      expect(searched_item.shortdesc).to eq item.shortdesc
      searched_item = Item.first_by_keyword("pimp cane")
      expect(searched_item).to eq nil
    end

    it "matches an item in an inventory" do
      inventory.items << item
      expect(inventory.by_keyword("obsidian").shortdesc).to eq "an obsidian dagger"
      expect(inventory.by_keyword("dragon helmet")).to eq nil
    end

  end

end
