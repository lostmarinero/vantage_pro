

Instagram.configure do |config|
  config.client_id = $CLIENT_ID
  config.client_secret = $CLIENT_SECRET
end


#====GET====#

get '/' do
  @all_events = Event.all
    results = Instagram.tag_recent_media("dbcvantagepoint")
  results.each do |image|
    new_image = Image.create(name: "image[:caption]",
            user_name: image[:user][:full_name],
             taken_at: image[:created_time], 
                  url: image[:images][:standard_resolution][:url])

    image[:tags].each do |tag|
      puts "tag #{tag}"
      if new_image.event = Event.find_by_tag(tag)
        new_image.save
        next
      end
    end
  end

  erb :index
end

get '/event/:id' do
  @event = Event.find(params[:id])
  erb :event
end

# get '/refresh' do


#     puts "User ID: #{image[:user][:full_name]}"
#     puts "Image URL: #{image[:images][:standard_resolution][:url]}"
#     puts "Tags: #{image[:tags].to_s}"
#     puts

#   end

#   redirect to('/')







#====POST====#

post '/create' do
  @event = Event.create(params[:event])
  if @event.valid?
    # exec("mkdir public/images/events/\"#{@event.name}\"")
    erb :event
  else
    redirect to '/'
  end
end
