require 'spec_helper'

describe "QuestionPages" do
	subject { page }

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		let!(:q1) { FactoryGirl.create(:question, user: user, content: "Foo") }

    before do
      sign_in user
      visit question_path(q1)
    end

    it { should have_content(q1.title) }
	end
end
