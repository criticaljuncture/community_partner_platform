require 'spec_helper'

describe User do
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
    describe ":organization member" do
      let(:user) { build(:organization_member) }

      it "is invalid without an organization id" do
        user.organization_id = nil
        
        expect( user ).to be_invalid
      end

      it "is valid with an organization id" do
        expect( user ).to be_valid
      end
    end
  end

  describe "#role?" do
    let(:user) { build(:user) }

    it "returns true when the user only possesses the given role" do
      user.stub(:roles).and_return( [Role.find_by_identifier(:organization_member)] )
      expect( user.role?(:organization_member) ).to eq(true)
    end

    it "returns true when the user possesses the given role (among many)" do
      user.stub(:roles).and_return( [Role.find_by_identifier(:school_manager), Role.find_by_identifier(:district_manager)] )
      expect( user.role?(:district_manager) ).to eq(true)
    end

    it "returns false when the user doesn not possess the given role" do
      user.stub(:roles).and_return( [Role.find_by_identifier(:school_manager)] )
      expect( user.role?(:admin) ).to eq(false)  
    end
  end
end
