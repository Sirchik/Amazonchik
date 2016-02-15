require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe CountriesController, type: :controller do

  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user)
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(@controller).to receive(:current_ability).and_return(@ability)
    @ability.can :manage, :all
    sign_in(@user)
  end

  # This should return the minimal set of attributes required to create a valid
  # Country. As you add validations to Country, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    # skip("Add a hash of attributes valid for your model")
    build(:country).attributes
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CountriesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all countries as @countries" do
      country = Country.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:countries)).to eq([country])
    end
  end

  describe "GET #show" do
    it "assigns the requested country as @country" do
      country = Country.create! valid_attributes
      get :show, {:id => country.to_param}, valid_session
      expect(assigns(:country)).to eq(country)
    end
  end

  describe "GET #new" do
    it "assigns a new country as @country" do
      get :new, {}, valid_session
      expect(assigns(:country)).to be_a_new(Country)
    end
  end

  describe "GET #edit" do
    it "assigns the requested country as @country" do
      country = Country.create! valid_attributes
      get :edit, {:id => country.to_param}, valid_session
      expect(assigns(:country)).to eq(country)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Country" do
        expect {
          post :create, {:country => valid_attributes}, valid_session
        }.to change(Country, :count).by(1)
      end

      it "assigns a newly created country as @country" do
        post :create, {:country => valid_attributes}, valid_session
        expect(assigns(:country)).to be_a(Country)
        expect(assigns(:country)).to be_persisted
      end

      it "redirects to the created country" do
        post :create, {:country => valid_attributes}, valid_session
        expect(response).to redirect_to(Country.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved country as @country" do
        post :create, {:country => invalid_attributes}, valid_session
        expect(assigns(:country)).to be_a_new(Country)
      end

      it "re-renders the 'new' template" do
        post :create, {:country => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        # skip("Add a hash of attributes valid for your model")
        build(:country).attributes
      }

      it "updates the requested country" do
        country = Country.create! valid_attributes
        put :update, {:id => country.to_param, :country => new_attributes}, valid_session
        country.reload
        # skip("Add assertions for updated state")
        test_fields = %w(name)
        test_fields.each do |field|
          expect(country[field]).to eq(new_attributes[field])
        end
      end

      it "assigns the requested country as @country" do
        country = Country.create! valid_attributes
        put :update, {:id => country.to_param, :country => valid_attributes}, valid_session
        expect(assigns(:country)).to eq(country)
      end

      it "redirects to the country" do
        country = Country.create! valid_attributes
        put :update, {:id => country.to_param, :country => valid_attributes}, valid_session
        expect(response).to redirect_to(country)
      end
    end

    context "with invalid params" do
      it "assigns the country as @country" do
        country = Country.create! valid_attributes
        put :update, {:id => country.to_param, :country => invalid_attributes}, valid_session
        expect(assigns(:country)).to eq(country)
      end

      it "re-renders the 'edit' template" do
        country = Country.create! valid_attributes
        put :update, {:id => country.to_param, :country => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested country" do
      country = Country.create! valid_attributes
      expect {
        delete :destroy, {:id => country.to_param}, valid_session
      }.to change(Country, :count).by(-1)
    end

    it "redirects to the countries list" do
      country = Country.create! valid_attributes
      delete :destroy, {:id => country.to_param}, valid_session
      expect(response).to redirect_to(countries_url)
    end
  end

end
