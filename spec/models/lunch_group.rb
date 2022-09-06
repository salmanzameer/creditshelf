require 'rails_helper'

RSpec.describe LunchGroup, type: :model do  
  let!(:user) { create(:user) }
  let!(:user1) { create(:user) }
  let!(:group) { create(:group)}
  let!(:group1) { create(:group, created_at: Date.today - 2.months )}
  let(:lunch_group1) { create(:lunch_group, created_at: Date.today - 2.months, group_id: group1.id, user_id: user.id )}
  let(:lunch_group2) { create(:lunch_group, group_id: group.id, user_id: user1.id )}

  context 'when current_month scope is called' do
    before do
      user.add_role :employee
      lunch_group1
      lunch_group2
    end

    it 'will return true' do
      expect(LunchGroup.current_month.pluck(:id).include?(lunch_group2.id)).to eq(true)
    end
    
    it 'will return false' do
      expect(LunchGroup.current_month.pluck(:id).include?(lunch_group1.id)).to eq(false)
    end
  end
end