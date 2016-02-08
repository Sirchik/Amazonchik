require 'rails_helper'
require "cancan/matchers"

RSpec.describe Ability, type: :model do
  subject(:ability){ Ability.new(user) }
  let(:user){ create(:user, role: role) }
  
  describe 'as guest' do
    let(:user){ nil }
    
    it {should be_able_to(:manage, :all)}
  end
  describe 'as customer' do
    let(:role) { Role.find_or_create_by(name: "Customer") }
    
  end
  describe 'as manager' do
    let(:role) { Role.find_or_create_by(name: "Manager") }
    
  end
  describe 'as admin' do
    let(:role) { Role.find_or_create_by(name: "Admin") }
    
  end
end
