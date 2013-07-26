require './lib/trello_event'
require './lib/flowdock_poster'

class App < Sinatra::Base

  helpers do
    def flowdock
      @flowdock ||= FlowDockPoster.new ENV['FLOWDOCK_TOKEN'], "lukasz+test@geckoboard.com"
    end
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
