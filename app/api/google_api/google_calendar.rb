# There may be some issues with this. I haven't made it work yet. 
# the issue is with the gem that is curerntly bundled in our project. it says it is deprecated, but the reference I found was from 2021 which is fairly recent.
require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

module GoogleApi
  module GoogleCalendar
    class CalendarEvent
      ADMIN_EMAIL = 'kencepallarca@gmail.com'
      ADMIN_NAME = 'Lance Pallarca'
      CALENDAR_ID = 'primary'
      TARGET_EMAIL = 'eefborromeo@gmail.com'
  
      def create_google_event(appointment_transaction)
        client = get_google_calendar_client
        _event = event_details(appointment_transaction)
        client.insert_event(CALENDAR_ID, _event)
      end
  
      def get_google_calendar_client
        client = Google::Apis::CalendarV3::CalendarService.new
        app_admin = User.find_by(email: ADMIN_EMAIL)
        # app_admin = User.find_by(admin: true, email: ADMIN_EMAIL) change to this when doctor has logged in using omniauth
        return unless (app_admin.present? && app_admin.access_token.present? && app_admin.refresh_token.present?)
      
        secrets = Google::APIClient::ClientSecrets.new({
          "web" => {
            "access_token" => app_admin.access_token,
            "refresh_token" => app_admin.refresh_token,
            "client_id" => ENV['GOOGLE_ID'],
            "client_secret" => ENV['GOOGLE_SECRET']
          }
        })
        begin
          client.authorization = secrets.to_authorization
          client.authorization.grant_type = "refresh_token"
      
          if app_admin.expired?
            client.authorization.refresh!
            app_admin.update(
              access_token: client.authorization.access_token,
              refresh_token: client.authorization.refresh_token,
              expires_at: client.authorization.expires_at.to_i
            )
          end
        rescue => error
          puts error.message
          raise StandardError
        end
        client
      end
  
      def event_details(appointment_transaction)
        event = Google::Apis::CalendarV3::Event.new({
          summary: "Dermatology Appointment | #{appt.appt_date.strftime('%-B %-d, %Y')} / #{appt.appt_time.strftime("%I:%M%p")} (#{appt.interaction})",
          location: "OITC-2 Oakridge Business Park, Mandaue City, Cebu",
          description: "Paid Appointment for: #{appt.reason}",
          start: {
            date_time: chrono_combine(appointment_transaction.appt_date, appointment_transaction.appt_time),
            time_zone: 'Asia/Manila', 
          },
          end: {
            date_time: chrono_combine(appointment_transaction.appt_date, appointment_transaction.appt_time) + 60.minutes,
            time_zone: 'Asia/Manila',
          },
          organizer: {
            email: ADMIN_EMAIL, 
            displayName: ADMIN_NAME
          },
          attendees: TARGET_EMAIL, # target email should be replaced with the patient who paid for the appointment. this is just placement for testing before going live
          reminders: {
            use_default: false
          },
          sendNotifications: true,
          sendUpdates: 'all'
        })
        event
      end
      
      def chrono_combine(appt_date, appt_time)
        d = appt_date
        t = appt_time.to_datetime.strftime('%T')
        Time.find_zone("Asia/Tokyo").parse("#{d} #{t}").to_datetime
      end
    end
  end
end