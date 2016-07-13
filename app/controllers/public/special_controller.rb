class Public::SpecialController < Public::ApplicationController

  def home
    @school = School.new
    @organization = Organization.new
  end

end
