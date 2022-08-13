class AppointmentController < ApplicationController
    before_action :check_user_info, if: :user_signed_in?
    include AppointmentHelper

    def index
      @appointments = Appointment.all
      @paid_appointments = current_user.appointment_transactions
      collection = good_and_bad_appointments
      @good_appointments = collection[0]
      @bad_appointments = collection[1]
    end

    def show
      @appointment = Appointment.find(params[:id])
    end

    def new
        @appointment = Appointment.new
        @slots = Slot.all
        @slot = Slot.find(params[:slot_id])
    end

    def destroy
      appointment = current_user.appointments.find(params[:id])
      appointment.destroy!
      redirect_to slot_index_path, notice: "Appointment successfully removed."
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
    
    def appointment_params
        params.require(:appointment).permit(:reason, :note, :status , :interaction, :user_id, :slot_id)
    end
end
