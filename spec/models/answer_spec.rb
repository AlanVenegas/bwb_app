require 'spec_helper'

describe Answer do

	let(:user) { FactoryGirl.create(:user) }
	let(:question) { FactoryGirl.create(:question)}
	before { @answer = Answer.new(content: "Lorem ipsum", user_id: user.id, question_id: question.id) }

	subject { @answer }

	it { should respond_to(:content) }
	it { should respond_to(:user_id) }
	it { should respond_to(:question_id) }
  its(:user) { should eq user }
  its(:question) { should eq question }

	it { should be_valid }

	describe "when user_id is not present" do
    before { @answer.user_id = nil }
    it { should_not be_valid }
  end

	describe "when question_id is not present" do
    before { @answer.question_id = nil }
    it { should_not be_valid }
  end

  describe "when content is empty" do
  	before { @answer.content = nil }
  	it { should_not be_valid }
  end


end
