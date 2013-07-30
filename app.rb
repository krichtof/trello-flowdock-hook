require 'trello_event'
require 'flowdock_poster'


class App < Sinatra::Base

  def flowdock
    @flowdock ||= FlowDockPoster.new ::APP_FLOWDOCK_TOKEN , "lukasz+test@geckoboard.com"
  end

  def trello
    @trello ||= TrelloClient.new  ::APP_TRELLO_DEVELOPER_API_KEY
  end

  get "/register-with-trello" do
    redirect trello.authorize_url, 302
  end

  get "/" do
    content_type "text/html"
    body <<-HTML
    <html>
    <title>Hi!</title>
    <body>
    <h1>Hello!</h1>
    <p><a href="/register-with-trello">Register this application with Trello</a></p>
    HTML
  end

  post "/hook" do
    payload = env['rack.input'].read
    flowdock.send_to_inbox JSON.parse payload
    body "OK"
  end

end
