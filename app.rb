require 'trello_event'
require 'flowdock_poster'

class App < Sinatra::Base

  helpers do
    def flowdock
      @flowdock ||= FlowDockPoster.new ::APP_FLOWDOCK_TOKEN , "lukasz+test@geckoboard.com"
    end
  end

  get "/get_auth_token" do
    redirect "https://trello.com/1/authorize?key=#{::APP_TRELLO_DEVELOPER_API_KEY}&name=TrelloFlowDockHook&response_type=token&scope=read,account&expiration=never", 302
  end

  get "/" do
    "Hello!"
  end

  post "/callback" do
    payload = env['rack.input'].read
    flowdock.send_to_inbox JSON.parse payload
    body "OK"
  end

end
