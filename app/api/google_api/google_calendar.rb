require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

module GoogleApi
  module GoogleCalendar
    class CalendarEvent
      CALENDAR_ID = 'primary'

      def create_google_event(appointment_transaction, patient)
        client = get_google_calendar_client
        _event = event_details(appointment_transaction, patient)
        client.insert_event(CALENDAR_ID, _event)
      end

      def get_google_calendar_client
        client = Google::Apis::CalendarV3::CalendarService.new
        app_admin = User.find_by(admin: true, email: ENV['ADMIN_EMAIL'])
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

      def event_details(appt, patient)
        event = Google::Apis::CalendarV3::Event.new(
          summary: "Dermatology Appointment | #{appt.appt_date.strftime('%-B %-d, %Y')} / #{appt.appt_time.strftime("%I:%M%p")} (#{appt.appt_interaction})",
          location: "OITC-2 Oakridge Business Park, Mandaue City, Cebu",
          description: "Paid Appointment for: #{appt.appt_reason}",
          start: {
            date_time: chrono_combine(appt.appt_date, appt.appt_time),
            time_zone: 'Asia/Manila', 
          },
          end: {
            date_time: chrono_combine(appt.appt_date, appt.appt_time) + 60.minutes,
            time_zone: 'Asia/Manila',
          },
          organizer: {
            email: ENV['ADMIN_EMAIL'], 
            displayName: ENV['ADMIN_NAME']
          },
          attendees: [
            {
              email: ENV['ADMIN_EMAIL'],
              displayName: ENV['ADMIN_NAME'],
              organizer: true
            },
            {
              email: patient.email,
              displayName: patient.full_name,
              organizer: false
            }
          ],
          reminders: {
            use_default: false
          },
          sendNotifications: true,
          sendUpdates: 'all'
        )
      end

      def chrono_combine(appt_date, appt_time)
        d = appt_date
        t = appt_time.to_datetime.strftime('%T')
        Time.find_zone("Asia/Tokyo").parse("#{d} #{t}").to_datetime
      end
    end
  end
end