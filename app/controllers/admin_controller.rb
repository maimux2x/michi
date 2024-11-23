class AdminController < ApplicationController
  allow_unauthenticated_access(only: :index)
  before_action :resume_session, only: [ :index ]

  def index
  end

  def dashbord
  end
end
