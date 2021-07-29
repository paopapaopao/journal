require 'rails_helper'

RSpec.describe 'EditCategory', type: :system do
  before :all do
    @category = Category.create!(:name => 'Hello')
  end

  it 'edits and shows the category' do
    visit "/categories/#{@category.id}/edit"
    fill_in 'Name', with: 'World'
    click_on 'Update Category'
    expect(page).to have_content('World')

    expect(category.name).to eq('World')
  end
end
