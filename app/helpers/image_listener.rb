class ImageListener

  def self.create_new_image(file_name)
    Image.create(name: InstaFileParser.caption(file_name),
                user_name: InstaFileParser.user_name(file_name),
                taken_at: InstaFileParser.date(file_name), 
                  url: file_name)
  end

  def self.find_corresponding_event(hashtags)
    Event.all.each do |event|
      puts "event.name: #{event.name}"
      puts "event.tag: #{event.tag}"
      if hashtags.include?(event.tag)
        return event
      end
    end
  end


  def self.start_listening
    puts "Listening for new files from Instagram via Dropbox"
    puts "'Ctrl+c' to quit"
    puts

    loop do
      all_existing_images = Image.all.map { |image| image.url }
      Dir.entries('public/images').each do |file_name|
        if file_name.include?(".jpg") && !all_existing_images.include?(file_name)
          puts "File: #{file_name}"
          puts "Hashtags: " + InstaFileParser.hashtags(file_name).inspect
          puts "Date: " + InstaFileParser.date(file_name).inspect
          puts "User_name: " + InstaFileParser.user_name(file_name)

          new_image = create_new_image(file_name)
          event = find_corresponding_event(InstaFileParser.hashtags(file_name))
          if event.class == Event
            new_image.event = event
            new_image.save
          end
        end
      end
      puts "Sleeping for 10 seconds"
      sleep(10)
      puts "Done sleeping, running again"
    # cron
    end


  end

end
