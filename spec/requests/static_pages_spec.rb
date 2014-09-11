require 'spec_helper'

describe "Static pages" do

  subject { page }
  describe "Home page" do
    before { visit root_path }

    it "should have the content 'Bienvenido'" do
      expect(page).to have_content('Bienvenido')
    end

    it { should have_link("Registrate", href: signup_path) }

  end
end
