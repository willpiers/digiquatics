require 'spec_helper'

describe Account do
  before { @account = Account.new(name: "City of Lakewood") }

  subject { @account }

  it { should respond_to :name }
end
