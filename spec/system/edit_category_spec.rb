require 'rails_helper'

RSpec.describe 'EditCategory', type: :system do
  it 'edits and shows the category' do
    # create
    visit '/categories/new'
    fill_in 'Name', with: 'Hello'
    click_on 'Create Category'
    expect(page).to have_content('Hello')

    category = Category.order('id').last
    expect(category.name).to eq('Hello')

    # edit
    visit "/categories/#{category.id}/edit"
    fill_in 'Name', with: 'World'
    click_on 'Edit Category'
    expect(page).to have_content('World')

    expect(category.name).to eq('World')
  end
end
