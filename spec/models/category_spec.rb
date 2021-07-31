require 'rails_helper'

RSpec.describe Category, type: :model do
  before :all do
    @category = Category.new
  end

  it 'has a name' do
    @category.name = 'Name'

    expect(@category).to be_valid
  end

  it 'does not have a name' do
    @category.name = ''

    expect(@category).to_not be_valid
  end

  it 'has a unique name' do
    @category.name = 'Unique Name'

    expect(@category).to be_valid
  end

  it 'does not have a unique name' do
    @category.name = 'Common Name'

    expect(@category).to_not be_valid
  end
end
