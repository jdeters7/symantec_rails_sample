class SymantecAuthController < ApplicationController

  include SymantecAuthHelper

	require "soteria"
	skip_before_action :symantec_auth

  def new
  end

  def otp
  end

  def new_credential
  end

  def add_credential
    transaction = soteria.add_credential(current_user.email, params[:credential], "STANDARD_OTP", {})

    if(transaction[:success])
      redirect_to root_path, notice: "Credential successfully added." and return
    else
      redirect_to root_path, notice: "Was not able to add credential." and return
    end
  end

  def otp_validate
    transaction_id = soteria.check_otp(current_user.email, params[:otp])

    if(transaction_id[:status] == "Success")
      set_second_auth
    else
      sign_out
    end

    redirect_to root_path and return
  end

  def push
    user_transaction = soteria.get_user_info(current_user.email, true)

    if user_transaction[:credentials]
      transaction_id = soteria.send_push(current_user.email, {})
      result = soteria.poll_for_response(transaction_id[:transaction_id], 5, 60)
      if result[:success] == true
        set_second_auth
      else
        sign_out
      end
      redirect_to root_path and return  
    else
      redirect_to root_path, notice: "You do not have a credential associated with this account." and return  
    end
    
  end

  def sms_send
    user_transaction = soteria.get_user_info(current_user.email, true)

    if user_transaction[:credentials]
      transaction_id = soteria.send_sms(current_user.email, user_transaction[:credentials][0][:credential_id])
      redirect_to symantec_auth_sms_code_path
    else
      redirect_to root_path, notice: "You do not have a credential associated with this account." and return  
    end
  end

  def sms_code
  end

  def sms_validate
    user_transaction = soteria.get_user_info(current_user.email, true)
    
    if user_transaction[:credentials]
      transaction_id = soteria.check_otp(current_user.email, params[:sms])

      if(transaction_id[:status] == "Success")
        set_second_auth
      else
        sign_out
      end

      redirect_to root_path and return
    else
      redirect_to root_path, notice: "You do not have a credential associated with this account." and return
    end
  end

  def create
  end

end
