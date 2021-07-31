require 'rails_helper'

RSpec.describe 'CreateCategory', type: :system do
  it 'creates and shows the category' do
    visit '/categories/new'

    fill_in 'Name', with: 'Not a unique name'

    click_on 'Create Category'

    expect(page).to have_content('Not a unique name')

    category = Category.order('id').last
    expect(category.name).to eq('Not a unique name')
  end
end
