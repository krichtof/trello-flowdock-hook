# encoding: utf-8
require "minitest/autorun"
require_relative "../lib/trello_event"

class TrelloEventTest < Minitest::Unit::TestCase

  def fixtures
    {
      "todo" => {
      "action"=> {
        "id"=> "51f283c9de2db62326005487",
        "idMemberCreator"=> "4f1013f347a46313720447d5",
      "data"=> {
        "listAfter"=> {
          "name"=> "Doing",
          "id"=> "501a80c4f8461b35739989e5"
        },
        "listBefore"=> {
          "name"=> "woop",
          "id"=> "51f25b1509eb5d8c060006a2"
        },
        "board"=> {
          "name"=> "Todo",
          "id"=> "501a80c4f8461b35739989e3"
        },
        "card"=> {
          "idShort"=> 8,
          "name"=> "Sheep",
          "id"=> "50237da1e817d8992d2cb680",
          "idList"=> "501a80c4f8461b35739989e5"
        },
        "old"=> {
          "idList"=> "51f25b1509eb5d8c060006a2"
        }
      },
      "type"=> "updateCard",
      "date"=> "2013-07-26T14=>12=>25.919Z",
      "memberCreator"=> {
        "id"=> "4f1013f347a46313720447d5",
        "avatarHash"=> "3c9f6eab13458fa259c43dcb13fa89e2",
        "fullName"=> "Łukasz Korecki",
        "initials"=> "ŁK",
        "username"=> "lukaszkorecki"
          }
        }
      }
    }
  end

  def event
    ::TrelloEvent.new(fixtures["todo"]["action"]).process
  end

  def test_subject
    assert_equal "Łukasz Korecki: Moved to Doing: Sheep", event.subject
  end

  def test_content
    assert_equal "<p>Updated</p><p><a href='https://trello.com/board/501a80c4f8461b35739989e3'>Board: https://trello.com/board/501a80c4f8461b35739989e3</a>", event.content
  end

  def test_from
    assert_equal "Łukasz Korecki", event.from
  end

  def test_project
    assert_equal "Todo", event.project
  end

  def test_card_link
    assert_equal "https://trello.com/card/501a80c4f8461b35739989e3/8", event.card_link
  end

end
