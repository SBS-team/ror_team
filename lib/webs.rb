# Abstraction layer around mechanism that we use to push new data to user
# Currently juggernaut is used.
require 'pusher'
require 'webs/notifier'
module Webs
  extend self
  
  def push(channel, data={})
    event = data.delete :event
    event(channel, event, data)
  end

  def event(channel, event, data={})
    return channel.map { |ch| event(ch, event, data) }.all? if channel.kind_of? Array

    begin
      pusher[channel].trigger(event, {'data' => data})
      logger.info "Triggered '#{event}' on '#{channel}' with #{ data.inspect }"
      true
    rescue Exception => e
      logger.info "Could not notify '#{event}' on '#{channel}' with #{ data.inspect } => #{e}", Logger::ERROR
      false
    end
  end

  def logger
    @logger ||= ActiveSupport::Logger.new("log/webs.log", Rails.logger.level)
  end

  def notify(event, *params)
    notifier.send event, *params
  end

  def pusher_config
    @application_config ||= (
      { :host => Settings.pusher.wss_host, :port => Settings.pusher.wss_port.to_s, :key => Settings.pusher.app_key, :ssl => Rails.env.production? || Rails.env.staging? }
    )
  end

  def pusher
    @pusher ||= (
    Pusher.encrypted = Rails.env.production? || Rails.env.staging?  #Enable or disable SLL depending from environment
    Pusher.host   = Settings.pusher.api_host
    Pusher.port   = Settings.pusher.api_port
                                                                    # Configure the application.
    Pusher.app_id = Settings.pusher.app_id
    Pusher.key = Settings.pusher.app_key
    Pusher.secret = Settings.pusher.app_secret
    @pusher = Pusher
    )
  end

  protected

  def notifier
    @notifier ||= Webs::Notifier.new self
  end

end
