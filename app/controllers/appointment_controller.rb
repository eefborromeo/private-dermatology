class AppointmentController < ApplicationController
    before_action :check_user_info, if: :user_signed_in?

    def index
      if current_user.admin?
        @appointments = Appointment.all
      else
        @appointments = current_user.appointments
      end
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
