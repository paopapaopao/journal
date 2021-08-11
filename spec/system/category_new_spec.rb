require 'rails_helper'

RSpec.describe 'Create Category', type: :system do
  let :existing_category do
    Category.create(
      title: 'not a unique title',
      description: 'a' * 55
    )
  end

  before :each do
    driven_by(:rack_test)

    Category.destroy_all
    visit(new_category_path)
  end

  context 'With invalid input field values' do
    it do
      expect(page).to have_text('New Category')
      expect(page).to have_current_path(new_category_path)

      fill_in 'Title', with: ''
      click_button('Create Category')
      expect(page).to have_text("Title can't be blank")

      existing_category
      fill_in 'Title', with: existing_category.title
      click_button('Create Category')
      expect(page).to have_text('Title has already been taken')

      fill_in 'Description', with: ''
      click_button('Create Category')
      expect(page).to have_text("Description can't be blank")

      fill_in 'Description', with: 'a' * 9
      click_button('Create Category')
      expect(page).to have_text('Description is too short (minimum is 10 characters)')

      fill_in 'Description', with: 'a' * 101
      click_button('Create Category')
      expect(page).to have_text('Description is too long (maximum is 100 characters)')
    end
  end

  context 'With valid input field values' do
    it do
      expect(page).to have_text('New Category')
      expect(page).to have_current_path(new_category_path)

      fill_in 'Title', with: 'new title'
      fill_in 'Description', with: 'a' * 20
      click_button('Create Category')
      expect(page).to have_current_path(category_path(Category.last))
    end
  end
end
