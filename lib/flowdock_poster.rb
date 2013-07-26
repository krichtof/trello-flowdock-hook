class FlowDockPoster
  def initialize room_token, from_address
    @room_token = room_token
    @from_addres = from_address

    @client = Faraday.new(:url => 'https://api.flowdock.com') do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end

  def send_to_inbox payload
    @client.post "/v1/messages/team_inbox/#{@room_token}", post_data(payload)
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
end
