# require 'spec_helper'

# describe 'POST create' do
#   context 'with valid attributes' do
#     it 'creates a new private lesson' do
#       expect do
#         post :create, private_lesson: Factory.attributes_for(:private_lesson)
#       end.to change(PrivateLesson, :count).by(1)
#     end

#     it 'redirects to the new private lesson' do
#       post :create, private_lesson: Factory.attributes_for(:private_lesson)

#       response.should redirect_to private_lesson.last
#     end
#   end

#   context 'with invalid attributes' do
#     it 'does not save the new private lesson' do
#       expect do
#         post :create,
#              private_lesson: Factory.attributes_for(:invalid_private_lesson)
#       end.to_not change(PrivateLesson, :count)
#     end

#     it 're-renders the new method' do
#       post :create,
#            private_lesson: Factory.attributes_for(:invalid_private_lesson)

#       response.should render_template :new
#     end
#   end
# end
