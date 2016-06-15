require 'spec_helper'

describe ProgressBarPresenter do

  context "#perform" do
    it "generates expected HTML" do
      result = ProgressBarPresenter.perform(
        percentage: 20,
        text: nil,
      )

      expect(result).to eq("<div class=\"progress\"><div class=\"progress-bar progress-bar- low\" style=\"width: 20%\" role=\"progressbar\" aria-valuenow=\"20\" aria-valuemin=\"0\" aria-valuemax=\"100\"></div></div>")
    end

    it "displays the special complete color when 100.0 is provided" do
      result = ProgressBarPresenter.perform(
        percentage: 100.0,
        text: nil,
        options: {special_complete_color: false}
      )

      expect(result).to eq("<div class=\"progress\"><div class=\"progress-bar progress-bar- complete\" style=\"width: 100.0%\" role=\"progressbar\" aria-valuenow=\"100.0\" aria-valuemin=\"0\" aria-valuemax=\"100\"></div></div>")
    end
  end

end
