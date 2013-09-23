#====GET====#

get '/' do
  @all_events = Event.all
  erb :index
end

get '/event/:id' do
  @event = Event.find(params[:id])
  erb :event
end

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
