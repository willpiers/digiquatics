require 'spec_helper'

describe ApplicationHelper do
  describe 'flash_messages' do
    it 'should create two empty divs with no args' do
      flash_messages.should ==
        '<div class="row"><div class="col-md-8 col-md-offset-2"></div></div>'
    end

    it 'should create flashes for each key value pair' do
      flash[:success] = 'Yay!'
      flash[:error]   = 'Boo..'

      flash_messages.should ==
        '<div class="row">' \
          '<div class="col-md-8 col-md-offset-2">' \
            '<div class="alert alert-success">Yay!</div>' \
            '<div class="alert alert-danger">Boo..</div>' \
          '</div>' \
        '</div>'
    end
  end
end
