require 'rails_helper'

RSpec.describe User, type: :model do  
  let(:user) { create(:user) }
  
  context 'when admin method is called' do
    context 'when user is admin' do
      before { user.add_role :admin }

      it 'will return true' do
        expect(user.admin?).to eq(true)
      end
    end

    context 'when user is not admin' do
      before { user.add_role :employee }

      it 'will return false' do
        expect(user.admin?).to eq(false)
      end
    end
  end

  context 'when employee method is called' do
    context 'when user is employee' do
      before { user.add_role :employee }

      it 'will return true' do
        expect(user.employee?).to eq(true)
      end
    end

    context 'when user is not employee' do
      before { user.add_role :admin }

      it 'will return false' do
        expect(user.employee?).to eq(false)
      end
    end
  end
end