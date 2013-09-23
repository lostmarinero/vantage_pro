class InstaFileParser

  def self.date(file_name)
    # return a date object based on the filename
    return nil unless file_name
    Date.parse(file_name[/(.*)_by_(.*)_on_(.*).jpg/,3])
  end

  def self.hashtags(file_name)
    # return an array of strings that are the hashtags from the filename
    return nil unless file_name
    #parses out the caption
    caption = file_name[/(.*)_by_(.*)_on_(.*).jpg/,1].downcase
    caption.gsub!(/__/,"#")
    caption.split('#')
  end

  def self.user_name(file_name)
    # return a single string of the user name
    return nil unless file_name
    file_name[/(.*)_by_(.*)_on_(.*).jpg/,2]
  end

  def self.caption(file_name)
    file_name[/(.*)_by_(.*)_on_(.*).jpg/,1].downcase
  end

end
