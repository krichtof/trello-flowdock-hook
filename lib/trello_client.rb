class TrelloClient

  def initialize developer_key
    @developer_key = developer_key
  end

  def authorize_url callback_url=""
    [
      "https://trello.com/1/authorize?key=",
      @developer_key,
      "&name=TrelloFlowDockHook&response_type=token",
      "&scope=read,account&expiration=never",
      callback_url
    ].join ''
  end


  def register_app token, hook_url, board_id
    response = client.post "/webhook?key=#@developer_key&webhookToken=#{token}&callbackURL=#{hook_url}&description=FlowdockHook&idModel=#{board_id}"
    [ resonse.status <= 300, response.body ]
  end

  private
  def client
    @client ||= Faraday.new(:url => 'https://trello.com/1') do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
  end
end
