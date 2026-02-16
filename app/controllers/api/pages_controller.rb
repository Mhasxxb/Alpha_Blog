module Api
  class PagesController < Api::ApplicationController
    def home
      redirect_to user_path(current_user.id) if logged_in?
    end
    def about
    end
  end
end