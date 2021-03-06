require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  let!(:product) {
    product = FactoryGirl.create(:product)
  }  

  let!(:address) {
    address = FactoryGirl.create(:address)
  }

  let!(:order) {
    order = FactoryGirl.create(:order)
  }

  let!(:shipment) {
    shipment = FactoryGirl.create(:shipment)
  }

  let!(:order_params) {
    order_params = { address_id: address.id, shipment_id: shipment.id, product_id: product.id, amount: 2 }
  }

  let!(:credit_card){
    credit_card = { type: 'VISA',number: '4111111111111111', cvv: '800', month: 10, year: 2021, first_name: 'test',
                    last_name: 'buyer'}
  }

  let!(:result){
    result = ActiveMerchant::Billing::Response.new(true, 'Success')
  }

  describe 'admin\'s paths' do
    before(:each) do
      admin = FactoryGirl.create(:admin)
      allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
      allow(controller).to receive(:current_user).and_return(admin)
    end

    describe 'GET #index' do
      it 'renders all orders in database' do
        get :index        
        expect(JSON.parse(response.body).to_json).to have_content(order.to_json)
      end
    end

    describe 'POST #create' do
      it 'responds with HTTP status 401' do
        post :create, order_params
        expect(response.status).to eq 401
      end

      it 'does not send confirmation mail' do
        expect { post :create, order_params }.to change(UserMailer.deliveries, :count).by(0)
      end

      it 'renders that this page is for authorized users only' do
        post :create, order_params
        expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Users only."]}).to_json
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        it 'responds with HTTP status 200' do
          allow(@order).to receive(:update_attributes!).and_return(true)
          put :update, id: order.id, status: 'Completed'
          expect(response.status).to eq 200
        end

        it 'updates an existing product' do
          put :update, id: order.id, status: 'Completed'
          expect(JSON.parse(response.body).to_json).to have_text('Completed')
        end
      end

      context 'with invalid params' do
        context 'with non-existing id' do
          it 'renders that object not found' do
            put :update, id: -(order.id), status: 'Completed'
            expect(response.status).to eq 404
            expect(response.body).to have_text('Object not found')
          end
        end
      end
    end

    # describe 'DELETE #destroy' do
    #   context 'with valid params' do
    #     it 'deletes an existing order' do
    #       expect { delete :destroy, id: order.id }.to change(Order, :count).by(-1)
    #     end

    #     it 'responds with HTTP status 302' do
    #       allow(@order).to receive(:destroy).and_return(true)
    #       delete :destroy, id: order.id
    #       expect(response.status).to eq 302
    #     end

    #     it 'redirects to index page' do
    #       allow(@order).to receive(:destroy).and_return(true)
    #       delete :destroy, id: order.id
    #       expect(response).to redirect_to api_v1_orders_path
    #     end
    #   end

    #   context 'with invalid params' do
    #     context 'with non-existing id' do
    #       it 'renders that object not found' do
    #         delete :destroy, id: -(order.id)
    #         expect(response.status).to eq 404
    #         expect(response.body).to have_text('Object not found')
    #       end
    #     end
    #   end
    # end
  end

  describe 'authenticated user\'s paths' do
    before(:each) do
      user = FactoryGirl.create(:user)
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe 'GET index' do
      it 'renders all orders which belong to a current user' do        
        allow(controller).to receive(:orders_list_for_user).and_return(order)       
        get :index        
        expect(JSON.parse(response.body).to_json).to have_content(order.to_json)
      end

      it 'does not render orders which belong to other users' do
        order2 = FactoryGirl.create(:order) 
        allow(controller).to receive(:orders_list_for_user).and_return(order)       
        get :index 
        expect(JSON.parse(response.body).to_json).not_to have_content(order2.to_json)
      end
    end

    describe 'POST #create' do
      context 'with valid params' do        
        it 'creates a new order' do
          controller.stub(:validate_card, credit_card)
          allow(result).to receive(:success?).and_return(true)
          expect { post :create, address_id: address.id, shipment_id: shipment.id,
                  products: [[], [id: product.id, amount: 2]], type: 'VISA',number: '4111111111111111',
                  cvv: '800', month: 10, year: 2021, first_name: 'test', last_name: 'buyer' }.to change(Order, :count).by(1)
        end

        it 'sends confirmation mail' do
          controller.stub(:validate_card, credit_card)
          allow(result).to receive(:success?).and_return(true)
          expect { post :create, address_id: address.id, shipment_id: shipment.id,
                  products: [[], [id: product.id, amount: 2]], type: 'VISA',number: '4111111111111111',
                  cvv: '800', month: 10, year: 2021, first_name: 'test', last_name: 'buyer' }.to change(UserMailer.deliveries, :count).by(1)
        end

        it 'responds with HTTP status 200' do
          controller.stub(:validate_card, credit_card)
          allow(result).to receive(:success?).and_return(true)
          post :create, address_id: address.id, shipment_id: shipment.id,
                        products: [[], [id: product.id, amount: 2]], type: 'VISA',number: '4111111111111111',
                        cvv: '800', month: 10, year: 2021, first_name: 'test', last_name: 'buyer'
          expect(response.status).to eq 200
        end
      end

      context 'with invalid payment params' do
        it 'does not create a new order' do
          controller.stub(:validate_card, credit_card)
          allow(result).to receive(:success?).and_return(false)
          expect { post :create, address_id: address.id, shipment_id: shipment.id,
                  products: [[], [id: product.id, amount: 2]], type: 'VISA',number: '4111111111111112',
                  cvv: '800', month: 10, year: 2021, first_name: 'test', last_name: 'buyer' }.to change(Order, :count).by(0)
        end

        it 'does not send confirmation mail' do
          controller.stub(:validate_card, credit_card)
          allow(result).to receive(:success?).and_return(false)
          expect { post :create, address_id: address.id, shipment_id: shipment.id,
                  products: [[], [id: product.id, amount: 2]], type: 'VISA',number: '4111111111111112',
                  cvv: '800', month: 10, year: 2021, first_name: 'test', last_name: 'buyer' }.to change(UserMailer.deliveries, :count).by(0)
        end

        it 'responds with HTTP status 400' do
          controller.stub(:validate_card, credit_card)
          allow(result).to receive(:success?).and_return(false)
          post :create, address_id: address.id, shipment_id: shipment.id,
                        products: [[], [id: product.id, amount: 2]], type: 'VISA',number: '4111111111111112',
                        cvv: '800', month: 10, year: 2021, first_name: 'test', last_name: 'buyer'
          expect(response.status).to eq 400
        end
      end
    end

    describe 'PUT #update' do
      it 'responds with HTTP status 401' do
        put :update, id: order.id
        expect(response.status).to eq 401
      end

      it 'renders that this page is for authorized users only' do
        put :update, id: order.id
        expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Admins only."]}).to_json
      end
    end

    # describe 'DELETE #destroy' do
    #   it 'responds with HTTP status 401' do
    #     delete :destroy, id: order.id
    #     expect(response.status).to eq 401
    #   end

    #   it 'renders that this page is for authorized users only' do
    #     delete :destroy, id: order.id
    #     expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Admins only."]}).to_json
    #   end
    # end
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

      it 'does not send confirmation mail' do
        expect { post :create, order_params }.to change(UserMailer.deliveries, :count).by(0)
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

    # describe 'DELETE #destroy' do
    #   it 'responds with HTTP status 401' do
    #     delete :destroy, id: order.id
    #     expect(response.status).to eq 401
    #   end

    #   it 'renders that this page is for authorized users only' do
    #     delete :destroy, id: order.id
    #     expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Authorized users only."]}).to_json
    #   end
    # end
  end
end