require 'rails_helper'

RSpec.describe 'Show Category', type: :system do
  before :all do
    Category.destroy_all
    @category = Category.create(name: 'Name')
  end

  it 'Shows the category' do
    visit(category_path(@category.id))

    expect(@category.name).to eq('Name')
    expect(page).to have_content('Name')
  end
end
