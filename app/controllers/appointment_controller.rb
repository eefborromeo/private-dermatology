class AppointmentController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index]
    before_action :check_user_info, if: :user_signed_in?

    def index
        @admin_appointments = Appointment.all
        @user_appointments = Appointment.where("patient_id = current_user")
    end

    def show
    end

    def new
        @appointment = Appointment.new
        @slots = Slot.all
        @slot = Slot.find(params[:slot_id])
    end

    def destroy
    end

    def create
        @appointment = Appointment.new(appointment_params)

        if @appointment.save
          redirect_to appointment_index_path,  notice: 'The appointment has been created.'
        else
          render :new, alert: @appointment.errors.first.full_message
        end
      end
    
    private
    def set_appointment
        @appointment = Appointment.find(params[:id])
    end

    def appointment_params
        params.require(:appointment).permit(:id, :date, :reason, :note, :status , :interaction, :user_id, :slot_id)
    end
end
