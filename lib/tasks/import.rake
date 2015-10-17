namespace :import do
  desc 'import players from slack'
  task import_world: :environment do
    slack = Slack::Client.new
    channels = slack.channels_list
    rooms_imported = 0
    channels['channels'].each do |channel|
      slackid = channel['id']
      print "importing #{slackid} \n"
      room = Room.find_or_create_by_slackid(slackid)
      sleep 1 # avoid rate limit issues with slack api
      rooms_imported += 1
      members = slack.channels_info(channel: slackid)['channel']['members']
      players_created = 0
      players = []
      members.each do |member_slackid|
        slackname = slack.users_info(user: member_slackid)['user']['name']
        player = Player.find_or_create_player_by_slack_info(member_slackid, slackname)
        print "created player #{player.name}, #{player.slackid} \n"
        sleep 2 # avoid rate limit issues with slack api
        players_created += 1
        players << player
      end
      room.players = players
      room.save
      print "total players imported: #{players_created} \n"
    end
    print "total rooms imported: #{rooms_imported} \n\n"
  end
end
