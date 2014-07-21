require 'spec_helper'

describe SubRequestsController do

    account = FactoryGirl.create(:account)
    let!(:user) { FactoryGirl.create(:user, account_id: account.id) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns @sub_requests' do
      sub_request = FactoryGirl.create(:sub_request, user_id: user.id)
      get :index
      assigns(:sub_requests).should eq([sub_request])
    end

    it 'renders the #index view' do
      get :index
      response.should render_template :index
    end
  end

  describe 'GET #show' do
    it 'assigns the requested sub_request to @sub_request' do
      sub_request = FactoryGirl.create(:sub_request)
      get :show, id: sub_request
      assigns(:sub_request).should eq(sub_request)
    end

    it 'renders the #show view' do
      get :show, id: FactoryGirl.create(:sub_request)
      response.should render_template :show
    end
  end

  describe 'GET #new' do
    it 'renders the #new view' do
      get :new
      response.should render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new sub_request' do
        expect{
          post :create, sub_request: FactoryGirl.attributes_for(:sub_request)
        }.to change(SubRequest, :count).by(1)
      end

      it 'redirects to the new sub_request' do
        post :create, sub_request: FactoryGirl.attributes_for(:sub_request)
        response.should redirect_to SubRequest.last
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new sub_request' do
        expect{
          post :create, sub_request: FactoryGirl.attributes_for(:invalid_sub_request)
        }.to_not change(SubRequest, :count)
      end

      it 're-renders the #new template' do
        post :create, sub_request: FactoryGirl.attributes_for(:invalid_sub_request)
        response.should render_template :new
      end
    end
  end

  describe 'PUT #update' do
    before :each do
      @sub_request = FactoryGirl.create(:sub_request)
    end

    context 'valid attributes' do
      it 'located the request @sub_request' do
        put :update, id: @sub_request, sub_request: FactoryGirl.attributes_for(:sub_request)
        assigns(:sub_request).should eq(@sub_request)
      end

      it "changes @sub_request's attributes" do
        put :update, id: @sub_request,
          sub_request: FactoryGirl.attributes_for(:sub_request, user_id: 2)
        @sub_request.reload
        @sub_request.user_id.should eq 2
      end

      it 'redirects to the updated sub_request' do
        put :update, id: @sub_request, sub_request: FactoryGirl.attributes_for(:sub_request)
        response.should redirect_to @sub_request
      end
    end

    context 'invalid attributes' do
      let(:new_start_time) { '2014-02-02 01:45:00' }
      let(:new_end_time) { '2014-02-02 06:45:00' }

      it 'locates the requested @sub_request' do
        put :update, id: @sub_request, sub_request: FactoryGirl.attributes_for(:invalid_sub_request)
        assigns(:sub_request).should eq(@sub_request)
      end

      it "changes @sub_request's attributes" do
        put :update, id: @sub_request,
          sub_request: FactoryGirl.attributes_for(:sub_request, user_id: nil)
        @sub_request.reload
        @sub_request.user_id.should eq 1
      end

      it 're-renders the #edit template' do
        put :update, id: @sub_request, sub_request: FactoryGirl.attributes_for(:invalid_sub_request)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @sub_request = FactoryGirl.create(:sub_request)
    end

    it 'deletes the sub_request' do
      expect{
        delete :destroy, id: @sub_request
      }.to change(SubRequest, :count).by(-1)
    end

    it 'redirects to sub_requests#index' do
      delete :destroy, id: @sub_request
      response.should redirect_to sub_requests_url
    end
  end
end


