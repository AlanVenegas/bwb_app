require 'spec_helper'

describe Question do

  let(:user) { FactoryGirl.create(:user) }
  before { @question = user.questions.build(content: "Lorem ipsum") }

  subject { @question }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @question.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @question.content = " " }
    it { should_not be_valid }
  end

end
