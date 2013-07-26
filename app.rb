class App < Sinatra::Base
  before do
    @flowdock_token=ENV['FLOWDOCK_TOKEN']


    @flowdock = Faraday.new(:url => 'https://api.flowdock.com') do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end

  end

  get "/" do
    "HELLO BOYS"
  end

  post "/callback" do
    status 410
  end

  post "/callback2" do
    payload = env['rack.input'].read
    payload += "="*80
    payload += "\n"
    payload += params.to_json
    payload += "\n"
    payload += env.to_json

    @flowdock.post "/v1/messages/team_inbox/#{@flowdock_token}", {
      :source => 'trello webhook',
        :from_address => 'lukasz+trello@ggeckoboard.com',
        :subject => 'webhooktest',
        :content => payload,
        :from_name => 'trello notifier',
        :project => 'trello notifier'}

  end

end
