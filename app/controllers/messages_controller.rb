class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def reply
    message_body = params["Body"]
    from_number = params["From"]
    text_analysis
    boot_twilio
    sms = @client.messages.create(
      from: Rails.application.secrets.twilio_number,
      to: from_number,
      body:  Indico.emotion("#{message_body}")
    )
  end

    # def send(call_back)
    # date_sent = params["DateSent"]
    # message_body = params["Body"]
    # to_number = params["To"]
    # boot_twilio
    # @client.messages.create(
    #   from: Rails.application.secrets.twilio_number,
    #   to:   to_number,
    #   date: date_sent,
    #   body: ""
    #   )
    # end

  private

  def boot_twilio
    account_sid = Rails.application.secrets.twilio_sid
    auth_token = Rails.application.secrets.twilio_token
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

  def text_analysis
   Indico.api_key = Rails.application.secrets.indico_token
  end
end