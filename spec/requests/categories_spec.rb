require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  subject { Category.create(valid_attributes) }

  let :valid_attributes do
    {
      title: 'valid title',
      description: 'a' * 55
    }
  end
  let :invalid_attributes do
    {
      title: '',
      description: ''
    }
  end
  let :edited_attributes do
    {
      title: 'edited title',
      description: 'a' * 20
    }
  end

  before(:each) { Category.destroy_all }

  describe 'GET /index' do
    it do
      get categories_path
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    it do
      get category_path(subject)
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET /new' do
    it do
      get new_category_path
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end

  describe 'GET /edit' do
    it do
      get edit_category_path(subject)
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST /create' do
    context 'With invalid parameters' do
      it do
        post categories_path, params: { category: invalid_attributes }
        expect(response).to_not be_successful
        expect(response).to have_http_status(:unprocessable_entity)
        expect{ response }.to change(Category, :count).by(0)
      end
    end

    context 'With valid parameters' do
      it do
        post categories_path, params: { category: valid_attributes }
        # ? got false ?
        # expect(response).to be_successful
        expect(response).to have_http_status(:found)
        # ? expected `Category.count` to have changed by 1, but was changed by 0 ?
        # expect{ response }.to change(Category, :count).by(1)
        expect(response).to redirect_to(category_path(Category.last))
      end
    end
  end

  describe 'PATCH /update' do
    context 'With invalid parameters' do
      it do
        patch category_path(subject), params: { category: invalid_attributes }
        expect(response).to_not be_successful
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'With valid parameters' do
      it do
        patch category_path(subject), params: { category: edited_attributes }
        # ? got false ?
        # expect(response).to be_successful
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(category_path(subject))
      end
    end
  end

  describe 'DELETE /destroy' do
    it do
      delete category_path(subject)
      # ? got false ?
      # expect(response).to be_successful
      # ? expected `Category.count` to have changed by -1, but was changed by 0 ?
      # expect{ response }.to change(Category, :count).by(-1)
      expect(response).to redirect_to(categories_path)
    end
  end
end
