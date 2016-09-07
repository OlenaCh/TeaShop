require 'rails_helper'

RSpec.describe Api::V1::AddressesController, type: :controller do
  let!(:address) {
    address = FactoryGirl.create(:address)
  }

  let!(:address_params) {
    address_params = { city: 'New York', zip_code: '10005', address: 'Wall street' }
  }

  describe 'admin\'s paths' do
    before(:each) do
      admin = FactoryGirl.create(:admin)
      allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
      allow(controller).to receive(:current_user).and_return(admin)
    end

    describe 'GET #index' do
      it 'responds with HTTP status 401' do
        get :index
        expect(response.status).to eq 401
      end

      it 'renders that this page is for users only' do
        get :index
        expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Users only."]}).to_json
      end
    end

    describe 'POST #create' do
      it 'responds with HTTP status 401' do
        post :create, address_params
        expect(response.status).to eq 401
      end

      it 'renders that this page is for users only' do
        post :create, address_params
        expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Users only."]}).to_json
      end
    end 

    describe 'PUT #update' do
      it 'responds with HTTP status 401' do
        put :update, id: address.id
        expect(response.status).to eq 401
      end

      it 'renders that this page is for users only' do
        put :update, id: address.id
        expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Users only."]}).to_json
      end
    end

    describe 'DELETE #destroy' do
      it 'responds with HTTP status 401' do
        delete :destroy, id: address.id
        expect(response.status).to eq 401
      end

      it 'renders that this page is for users only' do
        delete :destroy, id: address.id
        expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Users only."]}).to_json
      end
    end
  end

  describe 'authenticated user\'s paths' do
    context 'actions with own addresses' do
      before(:each) do
        user = FactoryGirl.create(:user)
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)      
        user.addresses << address
        allow(controller).to receive(:address_can_be_modified?).and_return(true)
      end

      describe 'GET index' do
        it 'responds with data concerning user\'s addresses' do
          get :index
          expect(JSON.parse(response.body).to_json).to have_content(address.to_json)
        end
      end

      describe 'POST #create' do
        context 'with valid params' do
          it 'responds with HTTP status 200' do
            post :create, address_params
            expect(response.status).to eq 200
          end

          it 'responds with success json message' do
            post :create, address_params
            expect(JSON.parse(response.body).to_json).to have_content('Success!')
          end
        end

        context 'with invalid params' do
          it 'responds with HTTP status 400' do
            post :create, city: 'a' * 30
            expect(response.status).to eq 400
          end

          it 'renders that no address created' do
            post :create, city: 'a' * 30
            expect(JSON.parse(response.body).to_json).to have_content('No address created!')
          end
        end
      end 

      describe 'PUT #update' do
        context 'with valid params' do
          it 'responds with HTTP status 200' do
            allow(Address).to receive(:find_by_id).and_return(address)
            put :update, id: address.id, city: 'Kyiv'        
            expect(response.status).to eq 200        
          end

          it 'responds with success json message' do
            allow(Address).to receive(:find_by_id).and_return(address)
            put :update, id: address.id, city: 'Kyiv'        
            expect(response.body).to have_content('Success!')
          end
        end

        context 'with invalid params' do
          it 'responds with HTTP status 404' do
            allow(Address).to receive(:find_by_id).and_return(nil)
            put :update, id: address.id, city: 'Kyiv'
            expect(response.status).to eq 404
          end

          it 'renders that object not found' do
            allow(Address).to receive(:find_by_id).and_return(nil)
            put :update, id: address.id, city: 'Kyiv'
            expect(JSON.parse(response.body).to_json).to have_content('Object not found')
          end
        end
      end

      describe 'DELETE #destroy' do
        context 'with valid params' do
          it 'responds with HTTP status 200' do
            allow(Address).to receive(:find_by_id).and_return(address)
            delete :destroy, id: address.id
            expect(response.status).to eq 200
          end

          it 'responds with success json message' do
            allow(Address).to receive(:find_by_id).and_return(address)
            delete :destroy, id: address.id
            expect(JSON.parse(response.body).to_json).to have_content('Success!')
          end
        end

        context 'with invalid params' do
          it 'responds with HTTP status 404' do
            allow(Address).to receive(:find_by_id).and_return(nil)
            delete :destroy, id: address.id
            expect(response.status).to eq 404
          end

          it 'renders that object not found' do
            allow(Address).to receive(:find_by_id).and_return(nil)
            delete :destroy, id: address.id
            expect(JSON.parse(response.body).to_json).to have_content('Object not found')
          end
        end
      end
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
      it 'does not create a new address' do
        expect { post :create, address_params }.to change(Address, :count).by(0)
      end

      it 'responds with HTTP status 401' do
        post :create, address_params
        expect(response.status).to eq 401
      end

      it 'renders that this page is for authorized users only' do
        post :create, address_params
        expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Authorized users only."]}).to_json
      end
    end

    describe 'PUT #update' do
      it 'responds with HTTP status 401' do
        put :update, id: address.id
        expect(response.status).to eq 401
      end

      it 'renders that this page is for users only' do
        put :update, id: address.id
        expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Authorized users only."]}).to_json
      end
    end

    describe 'DELETE #destroy' do
      it 'responds with HTTP status 401' do
        delete :destroy, id: address.id
        expect(response.status).to eq 401
      end

      it 'renders that this page is for users only' do
        delete :destroy, id: address.id
        expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Authorized users only."]}).to_json
      end
    end
  end
end