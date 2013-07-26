# Intro

## TODO

# Setup:

- deploy the app to heroku
- add 2 config values:

```
heroku config:set FLOWDOCK_TOKEN=your-room-token
heroku cconfig:set TRELLO_DEVELOPER_API_KEY=your-trello-dev-key


- deploy the app to heroku and visit `<app url>/get_auth_token`

# TODO
- copy the token and use it to authorize the webhook on trello with `create_webhook.sh` script
- That's it!
