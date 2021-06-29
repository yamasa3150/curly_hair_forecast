class LineBotController < ApplicationController
  protect_from_forgery except: [:callback]
  
  require 'line/bot'  # gem 'line-bot-api'
  require 'open-uri'
  require 'kconv'
  require 'rexml/document'

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body,signature)
      return head :bad_request
    end
    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          app_id = ENV["OPEN_WEATHER_MAP_APPID"]
          url = "http://api.openweathermap.org/data/2.5/forecast?q=Tokyo&appid=#{app_id}&units=metric&mode=xml"
         # XMLをパースしていく
          xml = open( url ).read.toutf8
          doc = REXML::Document.new(xml)
          xpath = 'weatherdata/forecast/time[1]/'
          now_wearther = doc.elements[xpath + 'symbol'].attributes['name']
          
          case event.message['text']
          when /.*(今日の予報).*/
            push = "今日の予報は、\n#{now_wearther}"
          end
          message = {
            type: 'text',
            text: push
          }
          client.reply_message(event['replyToken'], message)
          # LINEお友達追された場合
        when Line::Bot::Event::Follow
          line_user_id = event['source']['userId']
          User.create(line_user_id: line_user_id)
          # LINEお友達解除された場合
        when Line::Bot::Event::Unfollow
          line_user_id = event['source']['userId']
          User.find_by(line_user_id: line_user_id).destroy
        end
      end
    end
    head :ok
  end

  private
 
     def client
       @client ||= Line::Bot::Client.new { |config|
         config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
         config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
       }
     end
end
