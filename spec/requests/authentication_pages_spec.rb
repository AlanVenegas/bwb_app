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
			before { sign_in user }

			it { should have_title(user.name) }
			it { should have_link("Usuarios", 			href: users_path) }
			it { should have_link("Mi Perfil",     	href: user_path(user)) }
			it { should have_link("Editar Perfil",  href: edit_user_path(user)) }
			it { should have_link("Desconectar",    href: signout_path) }
			it { should_not have_link('Acceder',	  href: signin_path) }

			describe "followed by signout" do
				before { click_link "Desconectar" }
				it { should have_link('Acceder') }
			end
		end
	end

	describe "authorization" do

		describe "for non-signed-in users" do
			let(:user) { FactoryGirl.create(:user) }

			describe "when attempting to visit a protected page" do
				before do
					visit edit_user_path(user)
					fill_in "Email",    with: user.email
					fill_in "Password", with: user.password
					click_button "Acceder"
				end

				describe "after signing in" do

					it "should render the desired protected page" do
						expect(page).to have_title('Editar perfil')
					end
				end
			end

			describe "in the Users controller" do

				describe "visiting the edit page" do
					before { visit edit_user_path(user) }
					it { should have_title("Acceder") }
				end

				describe "submitting to the update action" do
					before { patch user_path(user) }
					specify { expect(response).to redirect_to(signin_path) }
				end

				describe "visiting the user index" do
					before { visit users_path }
					it { should have_title('Acceder') }
				end
			end
		end

		describe "as wrong user" do
			let(:user) { FactoryGirl.create(:user) }
			let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com", name:"Mr Wrong") }
			before { sign_in user, no_capybara: true }

			describe "submitting a GET request to the Users#edit action" do
				before { get edit_user_path(wrong_user) }
				specify { expect(response.body).not_to match('Actualiza tu perfil') }
				specify { expect(response).to redirect_to(root_url) }
			end

			describe "submitting a PATCH request to the Users#update action" do
				before { patch user_path(wrong_user) }
				specify { expect(response).to redirect_to(root_url) }
			end
		end

	end
end