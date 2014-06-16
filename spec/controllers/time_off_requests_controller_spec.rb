require 'spec_helper'

describe TimeOffRequestsController do
  before do
    account = FactoryGirl.create(:account)
    user = FactoryGirl.create(:user, account_id: account.id)
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns @time_off_requests' do
      time_off_request = FactoryGirl.create(:time_off_request)
      get :index
      assigns(:time_off_requests).should eq([time_off_request])
    end

    it 'renders the #index view' do
      get :index
      response.should render_template :index
    end
  end

  describe 'GET #show' do
    it 'assigns the requested time_off_request to @time_off_request' do
      time_off_request = FactoryGirl.create(:time_off_request)
      get :show, id: time_off_request
      assigns(:time_off_request).should eq(time_off_request)
    end

    it 'renders the #show view' do
      get :show, id: FactoryGirl.create(:time_off_request)
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
      it 'creates a new time_off_request' do
        expect{
          post :create, time_off_request: FactoryGirl.attributes_for(:time_off_request)
        }.to change(TimeOffRequest, :count).by(1)
      end
      it 'redirects to the new time_off_request' do
        post :create, time_off_request: FactoryGirl.attributes_for(:time_off_request)
        response.should redirect_to TimeOffRequest.last
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new time_off_request' do
        expect{
          post :create, time_off_request: FactoryGirl.attributes_for(:invalid_time_off_request)
        }.to_not change(TimeOffRequest, :count)
      end

      it 're-renders the #new template' do
        post :create, time_off_request: FactoryGirl.attributes_for(:invalid_time_off_request)
        response.should render_template :new
      end
    end
  end

  describe 'PUT #update' do
    before :each do
      @time_off_request = FactoryGirl.create(:time_off_request,
                                             user_id: 1,
                                             starts_at: Time.zone.now,
                                             ends_at: Time.zone.now + 5.hours)
    end

    context 'valid attributes' do
      let(:new_start_time) { '2014-02-02 01:45:00' }
      let(:new_end_time) { '2014-02-02 06:45:00' }

      it 'located the request @time_off_request' do
        put :update, id: @time_off_request, time_off_request: FactoryGirl.attributes_for(:time_off_request)
        assigns(:time_off_request).should eq(@time_off_request)
      end

      it "changes @time_off_request's attributes" do
        put :update, id: @time_off_request,
          time_off_request: FactoryGirl.attributes_for(:time_off_request,
                                                       user_id: 2,
                                                       starts_at: new_start_time,
                                                       ends_at: new_end_time)
        @time_off_request.reload
        @time_off_request.user_id.should eq 2
        @time_off_request.starts_at.should eq('Sun, 02 Feb 2014 08:45:00 UTC +00:00')
        @time_off_request.ends_at.should eq('Sun, 02 Feb 2014 13:45:00 UTC +00:00')
      end

      it 'redirects to the updated time_off_request' do
        put :update, id: @time_off_request, time_off_request: FactoryGirl.attributes_for(:time_off_request)
        response.should redirect_to @time_off_request
      end
    end

    context 'invalid attributes' do
      let(:new_start_time) { '2014-02-02 01:45:00' }
      let(:new_end_time) { '2014-02-02 06:45:00' }

      it 'locates the requested @time_off_request' do
        put :update, id: @time_off_request, time_off_request: FactoryGirl.attributes_for(:invalid_time_off_request)
        assigns(:time_off_request).should eq(@time_off_request)
      end

      it "changes @time_off_request's attributes" do
        put :update, id: @time_off_request,
          time_off_request: FactoryGirl.attributes_for(:time_off_request,
                                                       user_id: 2,
                                                       starts_at: nil,
                                                       ends_at: new_end_time)
        @time_off_request.reload
        @time_off_request.user_id.should_not eq 2
        @time_off_request.starts_at.should_not eq('Sun, 02 Feb 2014 08:45:00 UTC +00:00')
        @time_off_request.ends_at.should_not eq('Sun, 02 Feb 2014 13:45:00 UTC +00:00')
      end

      it 're-renders the #edit template' do
        put :update, id: @time_off_request, time_off_request: FactoryGirl.attributes_for(:invalid_time_off_request)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @time_off_request = FactoryGirl.create(:time_off_request)
    end

    it 'deletes the time_off_request' do
      expect{
        delete :destroy, id: @time_off_request
      }.to change(TimeOffRequest, :count).by(-1)
    end

    it 'redirects to time_off_requests#index' do
      delete :destroy, id: @time_off_request
      response.should redirect_to time_off_requests_url
    end
  end
end


