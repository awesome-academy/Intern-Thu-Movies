require "rails_helper"

RSpec.describe Admin::MoviesController, type: :controller do
  let(:admin_user){FactoryBot.create :user, role: "admin"}
  let!(:genre_1){FactoryBot.create :genre}
  let(:movie_test){FactoryBot.create :movie}

  context "When normal user login" do
    describe "GET #index" do
      before {get :index}
      it {expect(response).to redirect_to root_path}
    end

    describe "GET #new" do
      before {get :new}
      it {expect(response).to redirect_to root_path}
    end

    describe "PATCH #update" do
      before {patch :update, params: {id: movie_test.id}}
      it {expect(response).to redirect_to root_path}
    end

    describe "POST #create" do
      before {post :create}
      it {expect(response).to redirect_to root_path}
    end

    describe "DELETE #destroy" do
      before {delete :destroy, params: {id: movie_test.id}}
      it {expect(response).to redirect_to root_path}
    end

    describe "PATCH #lock" do
      before {patch :lock, params: {id: movie_test.id}}
      it {expect(response).to redirect_to root_path}
    end
  end

  context "When admin login" do
    before {sign_in admin_user}

    describe "GET #index" do
      before {get :index}
      it "should render index template" do
        expect(response).to render_template :index
      end
    end

    describe "GET #new" do
      before {get :new}
      it "should render new template" do
        expect(response).to render_template :new
      end
    end

    describe "PATCH #update" do
      context "when valid params" do
        before do
          patch :update, params: {id: movie_test.id, movie: {title: "Test Update"}}
        end

        it "should correct title" do
          expect(assigns(:movie).title).to eq "Test Update"
        end

        it "should redirect admin_movies_path" do
          expect(response).to redirect_to admin_movies_path
        end
      end

      context "when invalid params" do
        before do
          patch :update, params: {id: movie_test.id, movie: {title: nil}}
        end

        it "should a invalid movie" do
          expect(assigns(:movie).valid?).to eq false
        end

        it "should render template :edit" do
          expect(response).to render_template :edit
        end
      end
    end

    describe "POST #create" do
      context "when create success" do
        it "redirect_to admin page" do
          post :create, params: {movie: FactoryBot.attributes_for(:movie).merge(genre_id: genre_1.id)}
          expect(response).to redirect_to admin_movies_path
        end
      end

      context "When create movie failed" do
        it {expect{post :create, params: {movie: {title: nil}}}.to change(Movie, :count).by 0}
      end
    end

    describe "DELETE #destroy" do
      context "when destroy movie success" do
        before do
          delete :destroy, params: {id: movie_test.id}, xhr: true
        end

        it "delete success" do
          expect(assigns(:movie).destroyed?).to eq true
        end
      end

      context "when destroy movie failed" do
        before do
          allow_any_instance_of(Movie).to receive(:destroy).and_return false
          delete :destroy, params: {id: movie_test.id}, xhr: true
        end

        it "flash error message" do
          expect(flash[:danger]).to eq "Delete Fail"
        end
      end
    end

    describe "PATCH #lock" do
      context "when valid params" do
        before do
          patch :lock, params: {id: movie_test.id, status: "lock_movie"}, xhr: true
        end

        it "should correct status" do
          expect(assigns(:movie).status).to eq "lock_movie"
        end
      end

      context "when invalid params" do
        before do
          patch :lock, params: {id: movie_test.id, status: nil}, xhr: true
        end

        it "should a invalid movie" do
          expect(assigns(:movie).valid?).to eq false
        end
      end
    end
  end
end
