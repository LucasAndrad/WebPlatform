class OrganiserController < ApplicationController
  def index
    @organisers = User.where("role = ?", 1)

  end
end
