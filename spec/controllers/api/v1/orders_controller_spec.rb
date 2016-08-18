require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  let!(:product) {
    product = FactoryGirl.create(:product)
  }

  let!(:order_params) {
    order_params = { product_id: product.id, amount: 2 }
  }

  let!(:order) {
    order = FactoryGirl.create(:order)
  }

  describe 'admin\'s paths' do
    before(:each) do
      admin = FactoryGirl.create(:admin)
      allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
      allow(controller).to receive(:current_user).and_return(admin)
    end

    describe 'GET #index' do
      #
    end

    describe 'POST #create' do
      it 'responds with HTTP status 401' do
        post :create, order_params
        expect(response.status).to eq 401
      end

      it 'renders that this page is for authorized users only' do
        post :create, order_params
        expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Users only."]}).to_json
      end
    end

    describe 'PUT #update' do
      it 'responds with HTTP status 401' do
        put :update, id: order.id
        expect(response.status).to eq 401
      end

      it 'renders that this page is for authorized users only' do
        put :update, id: order.id
        expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Users only."]}).to_json
      end
    end
  end

  describe 'authenticated user\'s paths' do
    let!(:user) {
      user = FactoryGirl.create(:user)
    }

    before(:each) do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe 'GET index' do
      # it 'renders all products in database' do
      #   another_one = Product.create(:title => 'Indian Tea', :short_description => 'Green tea',
      #                                :long_description => 'Very tasty tea', :price => '30.0')
      #   get :index
      #   expect(JSON.parse(response.body).to_json).to eq [product, another_one].to_json
      # end
    end

    describe 'GET #show' do
      context 'with valid params' do
        it 'renders an existing order' do
          # get :show, id: order.id
          # expect(JSON.parse(response.body).to_json).to eq order.to_json
        end
      end

      # context 'with invalid params' do
      #   context 'with non-existing id' do
      #     it 'renders that object not found' do
      #       get :show, id: -(product.id)
      #       expect(response.status).to eq 404
      #       expect(response.body).to have_text('Object not found')
      #     end
      #   end
      # end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new order' do
          expect { post :create, order_params }.to change(Order, :count).by(1)
        end

        # it 'creates a new orders_product' do
        #   expect { post :create, order_params }.to change(OrdersProduct, :count).by(1)
        # end
        #
        # it 'responds with HTTP status 200' do
        #   post :create, order_params
        #   expect(response.status).to eq 200
        # end
      end

      # context 'with invalid params' do
      #   it 'does not create a new order' do
      #     expect { post :create, amount: -1, product_id: product.id }.to change(Order, :count).by(0)
      #   end
      #
      #   it 'responds with HTTP status 400' do
      #     post :create, amount: -1, product_id: product.id
      #     expect(response.status).to eq 400
      #   end
      # end
    end

    describe 'PUT #update' do
      # it 'responds with HTTP status 401' do
      #   put :update, id: product.id
      #   expect(response.status).to eq 401
      # end
      #
      # it 'renders that this page is for authorized users only' do
      #   put :update, id: product.id
      #   expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Admins only."]}).to_json
      # end
    end

    describe 'DELETE #destroy' do
      # it 'does not delete an existing product' do
      #   expect { delete :destroy, id: product.id }.to change(Product, :count).by(0)
      # end
      #
      # it 'responds with HTTP status 401' do
      #   delete :destroy, id: product.id
      #   expect(response.status).to eq 401
      # end
      #
      # it 'renders that this page is for authorized users only' do
      #   delete :destroy, id: product.id
      #   expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Admins only."]}).to_json
      # end
    end
  end

  describe 'random visitor\'s paths' do
    before(:each) do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
    end

    describe 'GET #index' do
      it 'responds with HTTP status 401' do
        get :index
        expect(response.status).to eq 401
      end

      it 'renders that this page is for authorized users only' do
        get :index
        expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Authorized users only."]}).to_json
      end
    end

    describe 'POST #create' do
      it 'does not create a new order' do
        expect { post :create, order_params }.to change(Order, :count).by(0)
      end

      it 'responds with HTTP status 401' do
        post :create, order_params
        expect(response.status).to eq 401
      end

      it 'renders that this page is for authorized users only' do
        post :create, order_params
        expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Authorized users only."]}).to_json
      end
    end

    describe 'PUT #update' do
      it 'responds with HTTP status 401' do
        put :update, id: order.id
        expect(response.status).to eq 401
      end

      it 'renders that this page is for authorized users only' do
        put :update, id: order.id
        expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Authorized users only."]}).to_json
      end
    end
  end
end