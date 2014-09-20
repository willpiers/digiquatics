require 'spec_helper'

describe ShiftsController do
  before do
    @compare_attrs = Shift.column_names - ['start_time', 'end_time']

    account = FactoryGirl.create(:account)
    user = FactoryGirl.create(:user, account_id: account.id)
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns @shifts' do
      shift = FactoryGirl.create(:shift)
      get :index
      assigns(:shifts).should eq([shift])
    end

    it 'renders the #index view' do
      get :index
      response.should render_template :index
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new shift' do
        expect do
          post :create, shift: FactoryGirl.attributes_for(:shift)
        end.to change(Shift, :count).by(1)
      end

      it 'sends the new shift as json' do
        post :create, shift: FactoryGirl.attributes_for(:shift)

        JSON.parse(response.body).slice(*@compare_attrs).should ==
          Shift.last.attributes.slice(*@compare_attrs)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new shift' do
        expect do
          post :create, shift: FactoryGirl.attributes_for(:invalid_shift)
        end.to_not change(Shift, :count)
      end

      it 'sends a 422 with an error message' do
        post :create, shift: FactoryGirl.attributes_for(:invalid_shift)

        response.status.should == 422
        response.body.should == { user_id: ["can't be blank"] }.to_json
      end
    end
  end

  describe 'PUT #update' do
    before :each do
      @shift = FactoryGirl.create(:shift, user_id: 1, location_id: 1,
                                          position_id: 1, start_time: Time.zone.now,
                                          end_time: Time.zone.now + 5.hours)
    end

    context 'valid attributes' do
      let(:new_start_time) { '2014-02-02 01:45:00' }
      let(:new_end_time) { '2014-02-02 06:45:00' }

      it 'located the request @shift' do
        put :update, id: @shift, shift: FactoryGirl.attributes_for(:shift)
        assigns(:shift).should eq(@shift)
      end

      it "changes @shift's attributes" do
        put :update, id: @shift,
                     shift: FactoryGirl.attributes_for(:shift, user_id: 2, location_id: 2,
                                                               position_id: 2,
                                                               start_time: new_start_time,
                                                               end_time: new_end_time)
        @shift.reload
        @shift.user_id.should eq 2
        @shift.location_id.should eq 2
        @shift.position_id.should eq 2
        @shift.start_time.should eq('Sun, 02 Feb 2014 08:45:00 UTC +00:00')
        @shift.end_time.should eq('Sun, 02 Feb 2014 13:45:00 UTC +00:00')
      end

      it 'sends the updated shift as json' do
        put :update, id: @shift, shift: FactoryGirl.attributes_for(:shift)

        JSON.parse(response.body).slice(*@compare_attrs).should ==
          Shift.last.attributes.slice(*@compare_attrs)
      end
    end

    context 'invalid attributes' do
      let(:new_start_time) { '2014-02-02 01:45:00' }
      let(:new_end_time) { '2014-02-02 06:45:00' }

      it 'locates the requested @shift' do
        put :update, id: @shift, shift: FactoryGirl.attributes_for(:invalid_shift)
        assigns(:shift).should eq(@shift)
      end

      it "changes @shift's attributes" do
        put :update, id: @shift,
                     shift: FactoryGirl.attributes_for(:shift, user_id: 2, location_id: nil,
                                                               position_id: 2,
                                                               start_time: new_start_time,
                                                               end_time: new_end_time)
        @shift.reload
        @shift.user_id.should_not eq 2
        @shift.location_id.should eq 1
        @shift.position_id.should_not eq 2
        @shift.start_time.should_not eq('Sun, 02 Feb 2014 08:45:00 UTC +00:00')
        @shift.end_time.should_not eq('Sun, 02 Feb 2014 13:45:00 UTC +00:00')
      end

      it 're-renders the #edit template' do
        put :update, id: @shift, shift: FactoryGirl.attributes_for(:invalid_shift)

        response.status.should == 422
        response.body.should == { user_id: ["can't be blank"] }.to_json
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @shift = FactoryGirl.create(:shift)
    end

    it 'deletes the shift' do
      expect do
        delete :destroy, id: @shift
      end.to change(Shift, :count).by(-1)
    end
  end
end
