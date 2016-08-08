require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do

  # let!(:admin) {
  #   admin = FactoryGirl.create(:user, role => "admin")
  # }

  let!(:user) {
    user = FactoryGirl.create(:user)
  }

  let!(:product_params) {
    product_params = FactoryGirl.attributes_for(:product)
  }

  let!(:product) {
    product = FactoryGirl.create(:product)
  }

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'creates a new product' do
        expect { post :create, product_params }.to change(Product, :count).by(1)
      end

      it 'responds with HTTP status 200' do
        post :create, product_params
        expect(response.status).to eq 200
      end
    end

    context 'with invalid params' do
      context 'with duplicated title' do
        it 'does not create a new product' do
          expect { post :create, product_params.merge({title: product.title}) }.to change(Product, :count).by(0)
        end

        it 'responds with HTTP status 400' do
          post :create, product_params.merge({title: product.title})
          expect(response.status).to eq 400
        end
      end
    end
  end

  describe 'GET edit' do
    context 'with valid params' do
      it 'renders an existing product' do
        get :edit, id: product.id
        expect(JSON.parse(response.body).to_json).to eq product.to_json
      end
    end

    context 'with invalid params' do
      context 'with non-existing id' do
        it 'renders that object not found' do
          get :edit, id: -(product.id)
          expect(response.status).to eq 404
          expect(response.body).to have_text('Object not found')
        end
      end
    end
  end

  describe 'GET show' do
    context 'with valid params' do
      it 'renders an existing product' do
        get :show, id: product.id
        expect(JSON.parse(response.body).to_json).to eq product.to_json
      end
    end

    context 'with invalid params' do
      context 'with non-existing id' do
        it 'renders that object not found' do
          get :show, id: -(product.id)
          expect(response.status).to eq 404
          expect(response.body).to have_text('Object not found')
        end
      end
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      it 'responds with HTTP status 200' do
        allow(@product).to receive(:update_attributes!).and_return(true)
        put :update, id: product.id
        expect(response.status).to eq 200
      end

      it 'renders an existing product' do
        allow(@product).to receive(:update_attributes!).and_return(true)
        put :update, id: product.id
        expect(JSON.parse(response.body).to_json).to eq product.to_json
      end
    end

    context 'with invalid params' do
      context 'with non-existing id' do
        it 'renders that object not found' do
          put :update, id: -(product.id)
          expect(response.status).to eq 404
          expect(response.body).to have_text('Object not found')
        end
      end
    end
  end

  describe 'DELETE destroy' do
    context 'with valid params' do
      it 'responds with HTTP status 200' do
        allow(@product).to receive(:destroy).and_return(true)
        delete :destroy, id: product.id
        expect(response.status).to eq 200
      end

      # it 'redirects to index page' do
      #   allow(@product).to receive(:destroy).and_return(true)
      #   delete :destroy, id: product.id
      #   expect(JSON.parse(response.body).to_json).to eq ("index").to_json
      # end
    end

    context 'with invalid params' do
      context 'with non-existing id' do
        it 'renders that object not found' do
          delete :destroy, id: -(product.id)
          expect(response.status).to eq 404
          expect(response.body).to have_text('Object not found')
        end
      end
    end
  end
end