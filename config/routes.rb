# == Route Map
#
#                     Prefix Verb   URI Pattern                           Controller#Action
#          symantec_auth_new GET    /symantec_auth/new(.:format)          symantec_auth#new
#         symantec_auth_push POST   /symantec_auth/push(.:format)         symantec_auth#push
#     symantec_auth_sms_send POST   /symantec_auth/sms_send(.:format)     symantec_auth#sms_send
#     symantec_auth_sms_code GET    /symantec_auth/sms_code(.:format)     symantec_auth#sms_code
# symantec_auth_sms_validate POST   /symantec_auth/sms_validate(.:format) symantec_auth#sms_validate
#           new_user_session GET    /users/sign_in(.:format)              users/sessions#new
#               user_session POST   /users/sign_in(.:format)              users/sessions#create
#       destroy_user_session DELETE /users/sign_out(.:format)             users/sessions#destroy
#              user_password POST   /users/password(.:format)             devise/passwords#create
#          new_user_password GET    /users/password/new(.:format)         devise/passwords#new
#         edit_user_password GET    /users/password/edit(.:format)        devise/passwords#edit
#                            PATCH  /users/password(.:format)             devise/passwords#update
#                            PUT    /users/password(.:format)             devise/passwords#update
#   cancel_user_registration GET    /users/cancel(.:format)               devise/registrations#cancel
#          user_registration POST   /users(.:format)                      devise/registrations#create
#      new_user_registration GET    /users/sign_up(.:format)              devise/registrations#new
#     edit_user_registration GET    /users/edit(.:format)                 devise/registrations#edit
#                            PATCH  /users(.:format)                      devise/registrations#update
#                            PUT    /users(.:format)                      devise/registrations#update
#                            DELETE /users(.:format)                      devise/registrations#destroy
#                       root GET    /                                     welcome#index
#

Rails.application.routes.draw do
  get 'symantec_auth/new'

  post 'symantec_auth/push'

  post 'symantec_auth/sms_send'

  get 'symantec_auth/sms_code'

  post 'symantec_auth/sms_validate'

  get 'symantec_auth/otp'

  post 'symantec_auth/otp_validate'

  get 'symantec_auth/new_credential'

  post 'symantec_auth/add_credential'


  # post 'symantec_auth/create'

  # devise_for :users
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  root to: 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
