require './lib/trello_event'
class App < Sinatra::Base
  before do
    @flowdock_token=ENV['FLOWDOCK_TOKEN']

    @flowdock = Faraday.new(:url => 'https://api.flowdock.com') do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end

  end

  helpers do
    def flowdock_post payload

      event = TrelloEvent.new(payload["action"]).process

      post_data = {
        :source       => event.source,
        :subject      => event.subject,
        :content      => event.content,
        :from_name    => event.from,
        :project      => event.project,
        :link         => event.card_link,
        :from_address => "lukasz+trello@geckoboard.com",
        :format       => 'html'
      }

      @flowdock.post "/v1/messages/team_inbox/#{@flowdock_token}", post_data
    end
  end

  get "/" do
    "Hello!"
  end

  head("/callback") { }
  post "/callback" do
    # TODO document this
    payload = env['rack.input'].read
    flowdock_post JSON.parse payload
    body "OK"
  end

end
