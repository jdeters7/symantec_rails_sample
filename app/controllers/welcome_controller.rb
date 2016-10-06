class WelcomeController < ApplicationController
	require "soteria"

  def index
  	@users = User.all
  	puts Soteria.why
  end
end
