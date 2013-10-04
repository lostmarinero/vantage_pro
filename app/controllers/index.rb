

Instagram.configure do |config|
  config.client_id = $CLIENT_ID
  config.client_secret = $CLIENT_SECRET
end


#====GET====#

get '/' do
  @all_events = Event.order("created_at DESC")
  results = Instagram.tag_recent_media("dbcvantagepoint")

  puts results.inspect

  results.each do |image|
    new_image = Image.create(name: image[:caption][0..250],
            user_name: image[:user][:full_name],
             taken_at: Time.at(image[:created_time].to_i).to_datetime,
                  url: image[:images][:standard_resolution][:url])

    image[:tags].each do |tag|
      puts "tag #{tag}"
      if new_image.event = Event.find_by_tag(tag.downcase)
        new_image.save
        next
      end
    end
  end

  erb :index
end


get '/api/event' do

  event_json = {}

  Event.all.each do |event|
    event_json[event.id] = { id: event.id,
                            name: event.name,
                            tag: event.tag }
  end
  content_type :json
  event_json.to_json
end


get '/api/event/:id' do
  event_id_json = {}

  Event.find(params[:id]).images.each do |image|
    event_id_json[image.id] = {id: image.id,
                              url: image.url,
                              user_name: image.user_name,
                              taken_at: image.taken_at }

  end
  content_type :json
  event_id_json.to_json
end


get '/event/:id' do
  @event = Event.find(params[:id])
  erb :event
end


#====POST====#

post '/create' do
  @event = Event.create(params[:event])
  if @event.valid?
    erb :event
  else
    redirect to '/'
  end
end
