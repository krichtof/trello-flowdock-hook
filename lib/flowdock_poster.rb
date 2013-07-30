class FlowDockPoster
  def initialize room_token, from_address
    @room_token = room_token
    @from_address = from_address
  end

  def send_to_inbox payload
    data = post_data(payload)
    response = @client.post "/v1/messages/team_inbox/#{@room_token}", data
    if response.status >= 300
      raise "FlowDock error!: #{response.body}"
    else
      "Posted to Flowdock!"
    end
  end

  def post_data payload
    event = TrelloEvent.new(payload["action"]).process

    {
      :source       => event.source,
      :subject      => event.subject,
      :content      => event.content,
      :from_name    => event.from,
      :project      => event.project,
      :link         => event.card_link,
      :from_address => @from_address,
      :format       => 'html'
    }
  end

  def client
    @client ||= Faraday.new(:url => 'https://api.flowdock.com') do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
  end
end
