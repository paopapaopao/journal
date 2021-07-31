require 'rails_helper'

RSpec.describe Category, type: :model do
  before :all do
    @new_category = Category.new
  end

  context 'Name validation' do
    context 'Without errors' do
      it 'Name is present' do
        @new_category.name = 'Name'

        expect(@new_category).to be_valid
      end

      it 'Name is unique' do
        @new_category.name = 'Unique Name'

        expect(@new_category).to be_valid
      end
    end

    context 'With errors' do
      it 'Name is not present' do
        @new_category.name = ''

        expect(@new_category).to_not be_valid
      end

      it 'Name is not unique' do
        existing_category = Category.create(name: 'Not a unique Name')
        @new_category.name = 'Not a unique Name'

        expect(@new_category).to_not be_valid
      end
    end
  end
end
