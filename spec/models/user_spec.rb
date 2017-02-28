require 'rails_helper'

RSpec.describe User do
  it "has valid factory" do
    user = build(:user)
    expect(user).to be_valid
  end

  context "validations" do
    let(:user) { build(:user) }

    it "is invalid without a first name" do
      user.first_name = nil
      expect( user ).to be_invalid
    end

    it "is invalid without a last name" do
      user.last_name = nil
      expect( user ).to be_invalid
    end

    it "is invalid without a email" do
      user.email = nil
      expect( user ).to be_invalid
    end

    it "is invalid without at least one role" do
      user.roles = []
      expect( user ).to be_invalid
    end
  end

  context "with role of" do
    describe "organization member" do
      let(:user) { build(:organization_user) }

      it "is invalid without an organization id" do
        user.organization_id = nil

        expect( user ).to be_invalid
      end

      it "is valid with an organization id" do
        expect( user ).to be_valid
      end
    end

    describe "school manager" do
      let(:user) { build(:school_manager_user) }

      it "is invalid without an school id" do
        user.school_ids = nil

        expect( user ).to be_invalid
      end

      it "is valid with an school id" do
        expect( user ).to be_valid
      end
    end
  end

  describe "#role?" do
    it "returns true when the user only possesses the given role" do
      user = build(:organization_user)
      expect( user.role?(:organization_member) ).to eq(true)
    end

    it "returns true when the user possesses the given role (among many)" do
      user = build(:multi_role_user)
      expect( user.role?(:school_manager) ).to eq(true)
      expect( user.role?(:organization_member) ).to eq(true)
    end

    it "returns false when the user doesn not possess the given role" do
      user = build(:organization_user)
      expect( user.role?(:district_manager) ).to eq(false)
    end
  end
end
