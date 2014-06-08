require 'spec_helper'

describe EmailGroup do
  before do
    @email_group = EmailGroup.new(user_email: 'matchmike1313@gmail.com',
                                  user_id: 1,
                                  account_id: 1,
                                  user_first_name: 'Michael',
                                  user_last_name: 'Pierce')
  end

  subject { @email_group }

  it { should respond_to :user_email }
  it { should respond_to :user_id }
  it { should respond_to :account_id }
  it { should respond_to :user_first_name }
  it { should respond_to :user_last_name }

end
