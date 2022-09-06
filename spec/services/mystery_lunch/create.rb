# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MysteryLunch::Create do
  let!(:user) { create(:user) }
  let(:department) { create(:department, name: 'sales') }
  let(:user1) { create(:user, department_id: department.id) }
  let(:user2) { create(:user, department_id: department.id) }
  let(:department1) { create(:department, name: 'marketing') }
  let(:user3) { create(:user, department_id: department1.id) }
  let(:department2) { create(:department, name: 'risk') }
  let(:user4) { create(:user, department_id: department2.id) }
  let(:group) { create(:group, created_at: Date.today - 2.months )}
  let(:lunch_group1) { create(:lunch_group, created_at: Date.today - 2.months, group_id: group.id, user_id: user.id )}
  let(:lunch_group2) { create(:lunch_group, created_at: Date.today - 2.months, group_id: group.id, user_id: user1.id )}
  let(:lunch_group3) { create(:lunch_group, created_at: Date.today - 2.months, group_id: group.id, user_id: user2.id )}
  let(:service_call) do
    MysteryLunch::Create.new(user, true).call
  end

  describe 'Create method is called' do
    before { user.add_role :employee }
    
    context 'when there is no group' do
      it 'will create a group' do
        expect{service_call}.to change{Group.count}.by(1)
      end

      it 'will create a Lunchgroup' do
        expect{service_call}.to change{LunchGroup.count}.by(1)
      end
    end

    context 'when 2 person sre added to group with diff department' do
      before do  
        user1.manage_mystery_group
        user2.manage_mystery_group
      end
      it 'will not add same department users to single group' do
        expect(Group.count).to eq(2)
      end
    end

    context 'when 3 persons added to a group' do
      before do  
        service_call
        user1.manage_mystery_group
        user3.manage_mystery_group
        user4.manage_mystery_group
      end
      it 'will not add same department users to single group' do
        expect(Group.first.lunch_groups.count).to eq(3)
      end

      it 'will not add same department users to single group' do
        expect(Group.count).to eq(2)
      end
    end

    context 'when 3 persons added to a group' do
      before do  
        service_call
        user1.manage_mystery_group
        user3.manage_mystery_group
        user4.manage_mystery_group
      end
      it 'will not add same department users to single group' do
        expect(Group.first.lunch_groups.count).to eq(3)
      end

      it 'will not add same department users to single group' do
        expect(Group.count).to eq(2)
      end
    end

    context 'when 3 persons added to a group previous month' do
      before do  
        group
        lunch_group1
        lunch_group2
        lunch_group3
        user.manage_mystery_group
        user1.manage_mystery_group
      end
      it 'will not add in same group' do
        expect(Group.count).to eq(3)
      end
    end
  end
end
