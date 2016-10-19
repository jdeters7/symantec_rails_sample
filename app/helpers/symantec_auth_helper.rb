module SymantecAuthHelper
	def set_second_auth
		session[:second_auth_user_id] = current_user.id
	end

	def second_auth_user_id
		@second_auth_id = session[:second_auth_user_id]
	end

	def end_session
		session[:second_auth_user_id] = nil
	end
end
