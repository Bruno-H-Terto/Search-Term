# spec/requests/searches_spec.rb
require 'rails_helper'

RSpec.describe "Searches", type: :request do
  describe "POST /searches" do
    context "when query is blank" do
      it "returns bad_request" do
        create(:user_ip, ip_address: "127.0.0.1")
        post searches_path, params: { query: " " }

        expect(response).to have_http_status(:bad_request)
      end
    end

    context "when user_ip not found" do
      it "returns not_found" do
        post searches_path, params: { query: "rails" }

        expect(response).to have_http_status(:not_found)
      end
    end

    context "when query is a new term" do
      it "creates a new search term" do
        user_ip = create(:user_ip, ip_address: "127.0.0.1")

        expect {
          post searches_path, params: { query: "rails testing" }
        }.to change { user_ip.searches.count }.by(1)
        expect(response).to have_http_status(:ok)
      end
    end

    context "when query starts with last term" do
      it "updates the last term" do
        user_ip = create(:user_ip, ip_address: "127.0.0.1")

        user_ip.searches.create!(term: "rails")
        last_search = user_ip.searches.last

        post searches_path, params: { query: "rails testing" }

        expect(response).to have_http_status(:ok)
        expect(last_search.reload.term).to eq("rails testing")
      end
    end

    context "when similar term exists" do
      it "updates the similar term" do
        user_ip = create(:user_ip, ip_address: "127.0.0.1")
        user_ip.searches.create!(term: "ruby on rails")
        allow(Search).to receive(:find_similar).and_return(user_ip.searches.last)
        similar_search = user_ip.searches.last

        post searches_path, params: { query: "ruby on rails 7" }

        expect(response).to have_http_status(:ok)
        expect(similar_search.reload.term).to eq("ruby on rails 7")
      end
    end
  end
end
