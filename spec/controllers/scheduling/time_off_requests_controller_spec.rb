require 'spec_helper'

describe TimeOffRequestsController do
  let!(:account) { FactoryGirl.create(:account) }
  let!(:user) { FactoryGirl.create(:user, account_id: account.id) }
  let!(:location) { FactoryGirl.create(:location, account_id: account.id) }

  before do
    @compare_attrs = TimeOffRequest.column_names - ['id', 'user_id', 'start_at', 'ends_at']
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns @time_off_requests' do
      time_off_request = FactoryGirl.create(:time_off_request,
                                            user_id: user.id,
                                            location_id: location.id)
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
        expect do
          post :create, time_off_request: FactoryGirl.attributes_for(:time_off_request)
        end.to change(TimeOffRequest, :count).by(1)
      end

      it 'sends the new time off request as json' do
        post :create, time_off_request: FactoryGirl.attributes_for(:time_off_request)
        parsed_body = JSON.parse(response.body)
        parsed_body['location_id'].should == TimeOffRequest.last.location_id
        parsed_body['user_id'].should == TimeOffRequest.last.user_id
        parsed_body['id'].should == TimeOffRequest.last.id
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new time_off_request' do
        expect do
          post :create, time_off_request: FactoryGirl.attributes_for(:invalid_time_off_request)
        end.to_not change(TimeOffRequest, :count)
      end

      it 'sends a 422 with an error message' do
        post :create, time_off_request: FactoryGirl.attributes_for(:invalid_time_off_request)

        response.status.should == 422
        response.body.should == { user_id: ["can't be blank"] }.to_json
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

      it 'sends the updated time off request as json' do
        put :update, id: @time_off_request, time_off_request: FactoryGirl.attributes_for(:time_off_request)
        parsed_body = JSON.parse(response.body)
        parsed_body['location_id'].should == TimeOffRequest.last.location_id
        parsed_body['user_id'].should == TimeOffRequest.last.user_id
        parsed_body['id'].should == TimeOffRequest.last.id
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
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @time_off_request = FactoryGirl.create(:time_off_request)
    end

    it 'deletes the time_off_request' do
      expect do
        delete :destroy, id: @time_off_request
      end.to change(TimeOffRequest, :count).by(-1)
    end
  end
end
