require 'spec_helper'

describe AvailabilitiesController do
  before do
    account = FactoryGirl.create(:account)
    user = FactoryGirl.create(:user, account_id: account.id)
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns @availabilities' do
      availability = FactoryGirl.create(:availability)
      get :index
      assigns(:availabilities).should eq([availability])
    end

    it 'renders the #index view' do
      get :index
      response.should render_template :index
    end
  end

  describe 'GET #show' do
    it 'assigns the requested availability to @availability' do
      availability = FactoryGirl.create(:availability)
      get :show, id: availability
      assigns(:availability).should eq(availability)
    end

    it 'renders the #show view' do
      get :show, id: FactoryGirl.create(:availability)
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
      it 'creates a new availability' do
        expect do
          post :create, availability: FactoryGirl.attributes_for(:availability)
        end.to change(Availability, :count).by(1)
      end
      it 'redirects to the new availability' do
        post :create, availability: FactoryGirl.attributes_for(:availability)
        response.should redirect_to Availability.last
      end
    end

    context 'with invalid attributes' do
      # Not possible with angular controller

      # it 'does not save the new availability' do
      #   expect{
      #     post :create, availability: FactoryGirl.attributes_for(:invalid_availability)
      #   }.to_not change(Availability, :count)
      # end

      # it 're-renders the #new template' do
      #   post :create, availability: FactoryGirl.attributes_for(:invalid_availability)
      #   response.should render_template :new
      # end
    end
  end

  describe 'PUT #update' do
    before :each do
      @availability = FactoryGirl.create(:availability, user_id: 1)
    end

    context 'valid attributes' do
      let(:new_start_time) { '2014-02-02 01:45:00' }
      let(:new_end_time) { '2014-02-02 06:45:00' }

      it 'located the request @availability' do
        put :update, id: @availability, availability: FactoryGirl.attributes_for(:availability)
        assigns(:availability).should eq(@availability)
      end

      it "changes @availability's attributes" do
        put :update, id: @availability,
                     availability: FactoryGirl.attributes_for(:availability, user_id: 2)
        @availability.reload

        # pulls in current user's id instead
        @availability.user_id.should eq 1
      end

      it 'redirects to the updated availability' do
        put :update, id: @availability, availability: FactoryGirl.attributes_for(:availability)
        response.should redirect_to @availability
      end
    end

    context 'invalid attributes' do

      it 'locates the requested @availability' do
        put :update, id: @availability, availability: FactoryGirl.attributes_for(:invalid_availability)
        assigns(:availability).should eq(@availability)
      end

      it "changes @availability's attributes" do
        put :update, id: @availability,
                     availability: FactoryGirl.attributes_for(:availability, user_id: nil)
        @availability.reload

        # pulls in current users id
        @availability.user_id.should eq 1
      end

      # Cannot submit invalid attributes with angular form

      # it 're-renders the #edit template' do
      #   put :update, id: @availability, availability: FactoryGirl.attributes_for(:invalid_availability)
      #   response.should render_template :edit
      # end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @availability = FactoryGirl.create(:availability)
    end

    it 'deletes the availability' do
      expect do
        delete :destroy, id: @availability
      end.to change(Availability, :count).by(-1)
    end

    it 'redirects to availabilities#index' do
      delete :destroy, id: @availability
      response.should redirect_to availabilities_url
    end
  end
end
