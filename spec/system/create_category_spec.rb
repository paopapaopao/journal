require 'rails_helper'

RSpec.describe 'Create Category', type: :system do
  before :all do
    Category.destroy_all
  end
  before :each do
    @size_before = Category.all.size
  end

  context 'Name validation' do
    context 'Without errors' do
      it 'Name is present' do
        visit(new_category_path)
        fill_in('Name', with: 'Name')
        click_button('Create Category')

        expect(Category.order(:id).last.name).to eq('Name')
        expect(@size_before + 1).to eq(Category.all.size)
        expect(page).to have_content('Category was successfully created.')
      end

      it 'Name is unique' do
        visit(new_category_path)
        fill_in('Name', with: 'Unique Name')
        click_button('Create Category')

        expect(Category.order(:id).last.name).to eq('Unique Name')
        expect(@size_before + 1).to eq(Category.all.size)
        expect(page).to have_content('Category was successfully created.')
      end
    end

    context 'With errors' do
      it 'Name is not present' do
        visit(new_category_path)
        fill_in('Name', with: '')
        click_button('Create Category')

        expect(@size_before).to eq(Category.all.size)
        expect(page).to have_content("Name can't be blank")
      end

      it 'Name is not unique' do
        existing_category = Category.create(name: 'Not a unique Name')

        visit(new_category_path)
        fill_in('Name', with: 'Not a unique Name')
        click_button('Create Category')

        expect(@size_before + 1).to eq(Category.all.size)
        expect(page).to have_content('Name has already been taken')
      end
    end
  end
end
