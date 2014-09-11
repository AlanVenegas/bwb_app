require 'spec_helper'

describe "Authentication" do

	subject { page }

	describe "signin page" do
		before { visit signin_path }

		it { should have_content('Acceder') }
		it { should have_title('Acceder') }
	end

	describe "signin" do
		before { visit signin_path }

		describe "with invalid information" do
			before { click_button "Acceder" }

			it { should have_title('Acceder') }
			it { should have_selector('div.alert.alert-error') }

			describe "after visiting another page" do
				before { click_link "Ir al Registro" }
				it { should_not have_selector('div.alert.alert-error') }
			end

		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				fill_in "Email",    with: user.email.upcase
				fill_in "Password", with: user.password
				click_button "Acceder"
			end

			it { should have_title(user.name) }
			it { should have_link("Mi Perfil",     href: user_path(user)) }
			it { should have_link("Desconectar",    href: signout_path) }
			it { should_not have_link('Acceder', href: signin_path) }

			describe "followed by signout" do
        before { click_link "Desconectar" }
        it { should have_link('Acceder') }
      end

		end

	end

end
