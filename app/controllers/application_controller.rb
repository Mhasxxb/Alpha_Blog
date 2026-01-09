class ApplicationController < ActionController::Base
  def hello
    render html: 'Chaaaa'
  end
end
