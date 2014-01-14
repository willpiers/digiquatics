require 'spec_helper'

describe CertificationsController do
  let(:account) { FactoryGirl.create(:account) }
  let(:user) { FactoryGirl.create(:user) }

  describe "GET certification_expirations.json" do
    # it "returns a json object with users and certification_names" do
    #   private_lesson = PrivateLesson.create! valid_attributes
    #   get :index, {}, valid_session
    #   assigns(:private_lessons).should eq([private_lesson])
    # end
  end
end

#   describe "GET show" do
#     it "assigns the requested private_lesson as @private_lesson" do
#       private_lesson = PrivateLesson.create! valid_attributes
#       get :show, {:id => private_lesson.to_param}, valid_session
#       assigns(:private_lesson).should eq(private_lesson)
#     end
#   end

#   describe "GET new" do
#     it "assigns a new private_lesson as @private_lesson" do
#       get :new, {}, valid_session
#       assigns(:private_lesson).should be_a_new(PrivateLesson)
#     end
#   end

#   describe "GET edit" do
#     it "assigns the requested private_lesson as @private_lesson" do
#       private_lesson = PrivateLesson.create! valid_attributes
#       get :edit, {:id => private_lesson.to_param}, valid_session
#       assigns(:private_lesson).should eq(private_lesson)
#     end
#   end

#   describe "POST create" do
#     describe "with valid params" do
#       it "creates a new PrivateLesson" do
#         expect {
#           post :create, {:private_lesson => valid_attributes}, valid_session
#         }.to change(PrivateLesson, :count).by(1)
#       end

#       it "assigns a newly created private_lesson as @private_lesson" do
#         post :create, {:private_lesson => valid_attributes}, valid_session
#         assigns(:private_lesson).should be_a(PrivateLesson)
#         assigns(:private_lesson).should be_persisted
#       end

#       it "redirects to the created private_lesson" do
#         post :create, {:private_lesson => valid_attributes}, valid_session
#         response.should redirect_to(PrivateLesson.last)
#       end
#     end

#     describe "with invalid params" do
#       it "assigns a newly created but unsaved private_lesson as @private_lesson" do
#         # Trigger the behavior that occurs when invalid params are submitted
#         PrivateLesson.any_instance.stub(:save).and_return(false)
#         post :create, {:private_lesson => { "first_name" => "invalid value" }}, valid_session
#         assigns(:private_lesson).should be_a_new(PrivateLesson)
#       end

#       it "re-renders the 'new' template" do
#         # Trigger the behavior that occurs when invalid params are submitted
#         PrivateLesson.any_instance.stub(:save).and_return(false)
#         post :create, {:private_lesson => { "first_name" => "invalid value" }}, valid_session
#         response.should render_template("new")
#       end
#     end
#   end

#   describe "PUT update" do
#     describe "with valid params" do
#       it "updates the requested private_lesson" do
#         private_lesson = PrivateLesson.create! valid_attributes
#         # Assuming there are no other private_lessons in the database, this
#         # specifies that the PrivateLesson created on the previous line
#         # receives the :update_attributes message with whatever params are
#         # submitted in the request.
#         PrivateLesson.any_instance.should_receive(:update).with({ "first_name" => "MyString" })
#         put :update, {:id => private_lesson.to_param, :private_lesson => { "first_name" => "MyString" }}, valid_session
#       end

#       it "assigns the requested private_lesson as @private_lesson" do
#         private_lesson = PrivateLesson.create! valid_attributes
#         put :update, {:id => private_lesson.to_param, :private_lesson => valid_attributes}, valid_session
#         assigns(:private_lesson).should eq(private_lesson)
#       end

#       it "redirects to the private_lesson" do
#         private_lesson = PrivateLesson.create! valid_attributes
#         put :update, {:id => private_lesson.to_param, :private_lesson => valid_attributes}, valid_session
#         response.should redirect_to(private_lesson)
#       end
#     end

#     describe "with invalid params" do
#       it "assigns the private_lesson as @private_lesson" do
#         private_lesson = PrivateLesson.create! valid_attributes
#         # Trigger the behavior that occurs when invalid params are submitted
#         PrivateLesson.any_instance.stub(:save).and_return(false)
#         put :update, {:id => private_lesson.to_param, :private_lesson => { "first_name" => "invalid value" }}, valid_session
#         assigns(:private_lesson).should eq(private_lesson)
#       end

#       it "re-renders the 'edit' template" do
#         private_lesson = PrivateLesson.create! valid_attributes
#         # Trigger the behavior that occurs when invalid params are submitted
#         PrivateLesson.any_instance.stub(:save).and_return(false)
#         put :update, {:id => private_lesson.to_param, :private_lesson => { "first_name" => "invalid value" }}, valid_session
#         response.should render_template("edit")
#       end
#     end
#   end

#   describe "DELETE destroy" do
#     it "destroys the requested private_lesson" do
#       private_lesson = PrivateLesson.create! valid_attributes
#       expect {
#         delete :destroy, {:id => private_lesson.to_param}, valid_session
#       }.to change(PrivateLesson, :count).by(-1)
#     end

#     it "redirects to the private_lessons list" do
#       private_lesson = PrivateLesson.create! valid_attributes
#       delete :destroy, {:id => private_lesson.to_param}, valid_session
#       response.should redirect_to(private_lessons_url)
#     end
#   end

# end
