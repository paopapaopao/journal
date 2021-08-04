require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  before :each do
    Category.destroy_all
  end

  let(:valid_attributes) do
    {
      name: 'Category Name',
    }
  end
  let(:invalid_attributes) do
    {
      name: nil,
    }
  end
  let(:new_attributes) do
    {
      name: 'Category Name Edited',
    }
  end

  subject do
    Category.new(valid_attributes)
  end

  let(:subject_save) { subject.save }
  let(:category_count) { Category.count }

  describe 'GET /index' do
    it 'finishes method successfully' do
      get categories_path
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'finishes method successfully' do
      subject_save
      get category_path(subject)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'finishes method successfully' do
      get new_category_path
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'finishes method successfully' do
      subject_save
      get edit_category_path(subject)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'With invalid parameters' do
      # it 'finishes method unsuccessfully' do
      #   subject_save
      #   post categories_path, params: { category: invalid_attributes }
      #   expect(category_count).to eq 0
      #   expect(response).to_not be_successful
      # end

      it "does not create a new Category" do
        expect {
          post categories_path, params: { category: invalid_attributes }
        }.to change(Category, :count).by(0)
      end

      it "displays the 'new' template)" do
        post categories_path, params: { category: invalid_attributes }
        expect(response).to_not be_successful
      end
    end

    context 'With valid parameters' do
      # it 'finishes method successfully' do
      #   subject_save
      #   post categories_path, params: { category: valid_attributes }
      #   expect(category_count).to eq 1
      #   expect(response).to be_successful
      # end

      it "creates a new Category" do
        expect {
          post categories_path, params: { category: valid_attributes }
        }.to change(Category, :count).by(1)
      end

      it "redirects to the created task" do
        post categories_path, params: { category: valid_attributes }
        expect(response).to redirect_to(category_path(Category.last))
      end
    end
  end

  describe 'PATCH /update' do
    context 'With invalid parameters' do
      # it 'finishes method unsuccessfully' do
      #   subject_save
      #   patch category_path(subject), params: { category: invalid_attributes }
      #   expect(category_count).to eq 1
      #   expect(response).to_not be_successful
      # end

      it "displays the 'edit' template)" do
        subject_save
        patch category_path(subject), params: { category: new_attributes }
        expect(response).to_not be_successful
      end
    end

    context 'With valid parameters' do
      # it 'finishes method successfully' do
      #   subject_save
      #   patch category_path(subject), params: { category: new_attributes }
      #   expect(category_count).to eq 1
      #   expect(response).to redirect_to(:category)
      # end

      it "updates the requested category" do
        subject_save
        count_before = Category.count
        patch category_path(subject), params: { category: new_attributes }
        subject.reload
        expect(Category.count).to eq(count_before)
      end

      it "redirects to the category" do
        subject_save
        patch category_path(subject), params: { category: new_attributes }
        subject.reload
        expect(response).to redirect_to(category_path(subject))
      end
    end
  end

  describe 'DELETE /destroy' do
    # it 'finishes method successfully' do
    #   subject_save
    #   delete category_path(subject)
    #   expect(category_count).to eq 0
    #   expect(response).to redirect_to(root_path)
    # end

    it "destroys the requested task" do
      subject_save
      expect {
        delete category_path(subject)
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the tasks list" do
      subject_save
      delete category_path(subject)
      expect(response).to redirect_to(categories_path)
    end
  end
end
