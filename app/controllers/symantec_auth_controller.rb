class SymantecAuthController < ApplicationController

  include SymantecAuthHelper

	require "soteria"
	skip_before_action :symantec_auth

  def new
  end

  def push
    soteria = Soteria.new("/Users/jack_deters/Downloads/publicCert.pem", "/Users/jack_deters/Downloads/privateKey.pem", "TeamSymantec1234")
    transaction_id = soteria.send_push("jack_phone", {})
    result = soteria.poll_for_response(transaction_id[:transaction_id], 5, 60)

    if result[:authenticated] == true
      set_second_auth
    else
      sign_out
    end
    redirect_to root_path and return
  end

  def sms_send
    soteria = Soteria.new("/Users/jack_deters/Downloads/publicCert.pem", "/Users/jack_deters/Downloads/privateKey.pem", "TeamSymantec1234")
    transaction_id = soteria.send_sms("jack_phone", "15175996147")

    redirect_to symantec_auth_sms_code_path
  end

  def sms_code
  end

  def sms_validate
    soteria = Soteria.new("/Users/jack_deters/Downloads/publicCert.pem", "/Users/jack_deters/Downloads/privateKey.pem", "TeamSymantec1234")
    transaction_id = soteria.check_otp("jack_phone", params[:sms])

    if(transaction_id[:status] == "Success")
      set_second_auth
    else
      sign_out
    end

    redirect_to root_path and return
  end

  def create
  end

end
