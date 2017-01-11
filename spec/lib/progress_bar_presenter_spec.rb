require 'spec_helper'

describe ProgressBarPresenter do

  context "#perform" do
    it "generates expected HTML" do
      result = ProgressBarPresenter.perform(
        percentage: 20
      )

      expect(result).to eq("<div class=\"progress\"><div class=\"progress-bar low\" style=\"width: 20%\" role=\"progressbar\" aria-valuenow=\"20\" aria-valuemin=\"0\" aria-valuemax=\"100\">20%</div></div>")
    end

    it "displays the special complete color when 100.0 is provided" do
      result = ProgressBarPresenter.perform(
        percentage: 100.0,
        options: {verification_required: false}
      )

      expect(result).to eq("<div class=\"progress\"><div class=\"progress-bar complete\" style=\"width: 100.0%\" role=\"progressbar\" aria-valuenow=\"100.0\" aria-valuemin=\"0\" aria-valuemax=\"100\">100%</div></div>")
    end
  end

end
