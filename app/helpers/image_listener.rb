class ImageListener

  def self.create_new_image(file_name)
    shortened_path = InstaFileParser.remove_amazon(file_name)
    Image.create(name: InstaFileParser.caption(shortened_path),
            user_name: InstaFileParser.user_name(shortened_path),
             taken_at: InstaFileParser.date(shortened_path), 
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

  def self.merge_aws(file_paths)

    all_existing_images = Image.all.map { |image| image.url }

    file_paths.each do |path|
      if file_name.include?(".jpg") && !all_existing_images.include?(file_name)
        new_image = create_new_image(path)
        event = find_corresponding_event(InstaFileParser.hashtags(InstaFileParser.remove_amazon(file_name)))
        if event.class == Event
          new_image.event = event
          new_image.save
        end
      end
    end
  end

  def self.start_amazon_listening
    loop do
      AWS::S3::Base.establish_connection!(
        :access_key_id     => 'AKIAJS3XDBKLGTXNZYAQ',
        :secret_access_key => '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'
      )

      image_bucket = AWS::S3::Bucket.find('dbcvantagepoint')

      ROOT_PATH = "https://s3-us-west-2.amazonaws.com/"

      image_paths = []

      image_bucket.objects.map do |obj|
        image_paths << (ROOT_PATH + obj.path)
      end

      ImageListener.merge_aws(image_paths)
      sleep(60)
    end
  end

  def self.start_listening
    puts "Listening for new files from Instagram via Dropbox"
    puts "'Ctrl+c' to quit"
    puts

    all_existing_images = Image.all.map { |image| image.url }

    loop do
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
      puts "Sleeping for 60 seconds"
      sleep(60)
      puts "Done sleeping, running again"
    # cron
    end
  end

end