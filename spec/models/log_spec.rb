require 'rails_helper'

RSpec.describe Log, type: :model do

  describe 'validations' do

    it 'must be created by an existing user and include a location' do
      create(:user)
      user = build(:user)

      create(:continent)
      continent = build(:continent)

      create(:location)
      location = build(:location)

      log1 = build(:log, user: nil, location: location)
      log2 = build(:log, user: user, location_id: nil)

      expect(log1.valid?).to eq(false)
      expect(log2.valid?).to eq(false)
      expect(log1.errors.full_messages).to eq(["User must exist"])
      expect(log2.errors.full_messages).to eq(["Location must exist"])
    end
  end
end
