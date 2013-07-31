# Intro

## TODO

# Deployment

## Heroku

- create the app to heroku
- add 3 config values:

```
heroku config:set FLOWDOCK_TOKEN=your-room-token
heroku cconfig:set TRELLO_DEVELOPER_API_KEY=your-trello-dev-key
heroku cconfig:set TRELLO_BOARD_ID=trello-board-id

- deploy the app to heroku
- visit `<app url>/register-with-trello` in your browser to register the app

That's it!


## Self-hosted

Make sure your app is accessible publicly on any port, SSL is recomended!

Start it with:

```bash
export FLOWDOCK_TOKEN=your-room-token
export TRELLO_DEVELOPER_API_KEY=your-trello-dev-key
export TRELLO_BOARD_ID=trello-board-id
bundle && bundle unicorn -c unicorn.rb
```
- visit `<app url>/register-with-trello` in your browser to register the app
