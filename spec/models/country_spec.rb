require 'rails_helper'

RSpec.describe Country, type: :model do
  let!(:country) { create(:country) }

  required_fields = %w(name)

  include_examples 'test fields', required_fields, []

  it {should validate_uniqueness_of(:name)}

  it '#to_s' do
    @country = create(:country)
    expect(@country.to_s).to eql(@country.name)
  end

end
