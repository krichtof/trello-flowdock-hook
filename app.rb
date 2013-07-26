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
    @flowdock.post "/v1/messages/team_inbox/#{@flowdock_token}", {
      :source => 'trello webhook',
        :from_address => 'lukasz+trello@ggeckoboard.com',
        :subject => 'webhooktest',
        :content => payload,
        :from_name => 'trello notifier',
        :project => 'trello notifier'}
    end
  end

  get "/" do
    "Hello!"
  end

  post "/callback" do
    # TODO document this
    payload = env['rack.input'].read
    flowdock_post payload
    body "OK"
  end

end
