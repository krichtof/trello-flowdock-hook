APP_FLOWDOCK_TOKEN = ENV['FLOWDOCK_TOKEN']
if not APP_FLOWDOCK_TOKEN
  STDOUT << "No flowdock token!"
  exit 1
end

APP_TRELLO_DEVELOPER_API_KEY = ENV['TRELLO_DEVELOPER_API_KEY']
if not APP_TRELLO_DEVELOPER_API_KEY
  STDOUT << "No Trello developer key!"
  exit 1
end

APP_TRELLO_BOARD_ID = ENV['TRELLO_BOARD_ID']
if not APP_TRELLO_BOARD_ID
  STDOUT << "No Trello board defined!"
  exit 1
end
