require 'rails_helper'

RSpec.describe 'CreateCategory', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'creates and shows the category' do
    visit '/categories/new'

    fill_in 'Name', with: 'Hello, World!'

    click_on 'Create Category'

    expect(page).to have_content('Hello, World!')

    category = Category.order('id').last
    expect(category.name).to eq('Hello, World!')
  end
end
