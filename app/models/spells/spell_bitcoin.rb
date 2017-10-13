class SpellBitcoin < GameCommandBase

  def initialize(game)
    super(game)
  end

  def perform
    slack_messenger.msg_room(room.slackid, message_to_room)
    I18n.t 'game.spell_bitcoin.success'
  end

  private

  def btc_price
    url = "https://api.coindesk.com/v1/bpi/currentprice/btc.json"
    json = JSON.parse(Net::HTTP.get(URI(url)))
    json["bpi"]["USD"]["rate_float"]
  end

  def message_to_room
    I18n.t 'game.spell_bitcoin.slack_success',
      playername: player.name,
      btc_price: btc_price
  end
end
