class Public::SpecialController < Public::ApplicationController
  def home
    @presenter = Public::HomePagePresenter.new
  end
end
