require 'rails_helper'

RSpec.describe 'Category Edit', type: :system do
  subject do
    Category.create(
      title: 'unique title',
      description: 'a' * 55
    )
  end

  let :existing_category do
    Category.create(
      title: 'not a unique title',
      description: 'a' * 55
    )
  end

  before :each do
    driven_by :rack_test

    Category.destroy_all
    visit edit_category_path(subject)
  end

  context 'With invalid input field values' do
    it do
      expect(page).to have_text 'Edit Category'
      expect(page).to have_current_path edit_category_path(subject)

      fill_in 'Title', with: ''
      fill_in 'Description', with: ''
      click_button 'Update Category'
      expect(page).to have_text "Title can't be blank"
      expect(page).to have_text "Description can't be blank"

      existing_category
      fill_in 'Title', with: existing_category.title
      click_button 'Update Category'
      expect(page).to have_text 'Title has already been taken'

      fill_in 'Description', with: 'a' * 9
      click_button 'Update Category'
      expect(page).to have_text 'Description is too short (minimum is 10 characters)'

      fill_in 'Description', with: 'a' * 101
      click_button 'Update Category'
      expect(page).to have_text 'Description is too long (maximum is 100 characters)'
    end
  end

  context 'With valid input field values' do
    it do
      expect(page).to have_text 'Edit Category'
      expect(page).to have_current_path edit_category_path(subject)

      fill_in 'Title', with: 'edited title'
      fill_in 'Description', with: 'a' * 20
      click_button 'Update Category'
      expect(page).to have_current_path category_path(subject)
    end
  end

  context 'Clicks Show' do
    it do
      expect(page).to have_text 'Edit Category'
      expect(page).to have_current_path edit_category_path(subject)

      click_link 'Show'
      expect(page).to have_text subject.id
      expect(page).to have_text subject.title
      expect(page).to have_text subject.description
      expect(page).to have_current_path category_path(subject)
    end
  end

  context 'Clicks Back' do
    it do
      expect(page).to have_text 'Edit Category'
      expect(page).to have_current_path edit_category_path(subject)

      click_link 'Back'
      expect(page).to have_text 'Categories'
      expect(page).to have_current_path categories_path
    end
  end
end
