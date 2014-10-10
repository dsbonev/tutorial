require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe 'profile page' do
    let(:user) { FactoryGirl.create :user }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit_button) { "Create my account" }

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit_button }.to change(User, :count).by(1)
      end
    end

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit_button }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit_button }

        it 'should have expected title' do
          subject.title.should eq full_title('Sign up')
        end

        it { should have_content('errors') }
      end
    end
  end
end
