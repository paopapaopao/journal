require 'rails_helper'

RSpec.describe 'Category Show', type: :system do
  subject do
    Category.create(
      title: 'unique title',
      description: 'a' * 55
    )
  end

  before :each do
    driven_by(:rack_test)

    Category.destroy_all
    visit(category_path(subject))
  end

  context 'Shows the category' do
    it do
      expect(page).to have_text(subject.id)
      expect(page).to have_text(subject.title)
      expect(page).to have_text(subject.description)
      expect(page).to have_current_path(category_path(subject))
    end
  end

  context 'Clicks Edit' do
    it do
      expect(page).to have_text(subject.id)
      expect(page).to have_text(subject.title)
      expect(page).to have_text(subject.description)
      expect(page).to have_current_path(category_path(subject))

      click_link 'Edit'
      expect(page).to have_text('Edit Category')
      expect(page).to have_current_path(edit_category_path(subject))
    end
  end

  context 'Clicks Back' do
    it do
      expect(page).to have_text(subject.id)
      expect(page).to have_text(subject.title)
      expect(page).to have_text(subject.description)
      expect(page).to have_current_path(category_path(subject))

      click_link 'Back'
      expect(page).to have_text('Categories')
      expect(page).to have_current_path(categories_path)
    end
  end
end
