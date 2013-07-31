require 'trello_event'
require 'trello_client'
require 'flowdock_poster'


class App < Sinatra::Base

  helpers do
    def flowdock
      @flowdock ||= FlowDockPoster.new ::APP_FLOWDOCK_TOKEN , "lukasz+test@geckoboard.com"
    end

    def trello
      @trello ||= TrelloClient.new  ::APP_TRELLO_DEVELOPER_API_KEY
    end

    def app_url
      env['REQUEST_URI'].to_s.sub(env['PATH_INFO'], '')
    end
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


  get "/register-with-trello" do
    callback_url = app_url()+"/comeback"
    redirect trello.authorize_url(callback_url), 302
  end

  # ok this is were it gets funny!
  # after get_auth_token redirects us to trello and user authorizes
  # we come back to /comeback#token=THETOKEN
  #
  # Sinatra and rack disappoint me here because there's no way I can
  # get the full url and extract the token, so we have to rely on
  # good 'ol Javascript to do the hard work, which is extracting the token
  # and redirecting to the real endpoint which will register this application
  get "/comeback" do
    body <<-HACKYHTML
    <script>
    window.location = (""+window.location).replace(/comeback.*token=/, "register/");
    </script>
    HACKYHTML
  end

  get "/register/:token" do |token|
    hook_url = app_url()+"/hook"
    ok, response = trello.register_app token, hook_url, ::APP_TRELLO_BOARD_ID
    [ ok ? 201 : 400, response ]
  end

  post "/hook" do
    payload = env['rack.input'].read
    flowdock.send_to_inbox JSON.parse payload
    body "OK"
  end

end
