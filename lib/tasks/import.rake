namespace :import do
  desc 'import users from slack to game'
  task import_players: :environment do
    puts '-> importing users'
    slack = Slack::Client.new
    # import users
    slack.users_list['members'].each do |member|
      begin
        puts 'importing ' + member['name']
        Player.create_player_by_slack_info(member['id'], member['name'])
      rescue
        puts 'member already existed for ' + member['name']
      end
    end
    # import rooms
  end

  desc 'import rooms from slack to game'
  task import_rooms: :environment do
    puts 'importing rooms'
    slack = Slack::Client.new
    slack.channels_list['channels'].each do |channel|
      begin
        puts 'importing ' + channel['name']
        Room.create_room_from_channel(channel)
      rescue
        puts 'room already exists for room ' + channel['name']
      end
    end
  end

  desc 'add players to rooms'
  task add_players_to_rooms: :environment do
    puts '-> adding players to rooms'
    slack = Slack::Client.new
    slack.channels_list['channels'].each do |channel|
      begin
        puts "adding player to room #{channel['name']}"
        room = Room.where(slackid: channel['id']).first
        players = Player.where(slackid: channel['members'])
        room.update!(players: players)
        puts "added #{players.map(&:name)} to room #{room[:title]}"
      rescue => e
        puts "something went wrong when adding players to room #{room[:title]}"
        puts e
      end
    end
  end

  desc 'import world'
  task import_world: :environment do
    begin
    Rake::Task["import:import_players"].invoke
    Rake::Task["import:import_rooms"].invoke
    Rake::Task["import:add_players_to_rooms"].invoke
    rescue => e
      puts "something went horribly wrong!"
      puts e
    end
    puts "import complete!"
  end

  #desc 'import players from slack'
  #task import_world: :environment do
    #slack = Slack::Client.new
    #channels = slack.channels_list
    #rooms_imported = 0
    #channels['channels'].each do |channel|
      #slackid = channel['id']
      #print "importing #{slackid} \n"
      #room = Room.find_or_create_by_slackid(slackid)
      #sleep 1 # avoid rate limit issues with slack api
      #rooms_imported += 1
      #members = slack.channels_info(channel: slackid)['channel']['members']
      #players_created = 0
      #players = []
      #members.each do |member_slackid|
        #slackname = slack.users_info(user: member_slackid)['user']['name']
        #player = Player.find_or_create_player_by_slack_info(member_slackid, slackname)
        #print "created player #{player.name}, #{player.slackid} \n"
        #sleep 2 # avoid rate limit issues with slack api
        #players_created += 1
        #players << player
      #end
      #room.players = players
      #room.save
      #print "total players imported: #{players_created} \n"
    #end
    #print "total rooms imported: #{rooms_imported} \n\n"
  #end
end
