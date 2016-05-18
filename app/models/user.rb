class User < ActiveRecord::Base
  has_secure_password
  has_many :favorites
  has_many :global_data_objects, through: :favorites
  has_many :local_data_objects

  validates :first_name, :last_name, :alert_level, presence: true
  validates :email, :phone, presence: true, uniqueness: true
 validates_format_of :first_name, with: /\D[a-z]/
 validates_format_of :last_name, with: /\D[a-z]/
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create
  validates_format_of :phone, :with => /\A\d{3}-\d{3}-\d{4}\z/, on: :create


  def check_threshold(alert, global_data_object)
    # AQI is above user threshold
    if alert_level < global_data_object.breezometer_aqi
      alert.ready_to_send? == true
    end
  end

  def send_alert(alert)
    message = alert.message
    phone_number = phone

    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token

    twilio_number = Rails.application.secrets.twilio_number

    final_message = client.messages.create(
      from: twilio_number,
      to: phone_number,
      body: message,)


    rescue Twilio::REST::RequestError => e
      puts e.message

  end


end
