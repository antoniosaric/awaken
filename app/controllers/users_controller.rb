class UsersController < ApplicationController

	def show
	  @user = current_user
	end

  def update
    update_status = current_user.update(user_params)
		flash.notice = "ALARM UPDATED THO"

    respond_to do |format|
        AlarmQueue.perform_now(current_user.id)
        # render text: "ALARM SETTING HAS BEEN ADDED TO THE QUEUE"
        format.html { redirect_to current_user, notice: 'Alarm was successfully updated.' }
        format.json { render :show, status: :created, location: current_user }
    end
  end

	def change_weather
		current_user.toggle_weather
	end


private

  def user_params
    params.require(:user).permit(:time, :weather, :zip)
  end

end


