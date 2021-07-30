require 'rails_helper'

RSpec.describe 'ShowCategory', type: :system do
  before :all do
    @category = Category.create!(:name => 'Hello')
  end

  it 'shows the category' do
    visit "/categories/#{@category.id}"
    expect(page).to have_content('Hello')

    expect(@category.name).to eq('Hello')
  end
end
