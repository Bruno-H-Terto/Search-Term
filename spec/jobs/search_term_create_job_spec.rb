require 'rails_helper'

RSpec.describe SearchTermCreateJob, type: :job do
  it "executes the job logic correctly" do
    user_ip = UserIp.create!(ip_address: "127.0.0.1")
    user_ip.searches.create!(term: "test")

    SearchTermCreateJob.perform_now(user_ip: user_ip, term: "test123")
    expect(user_ip.searches.last.term).to eq("test123")

    similar_search = user_ip.searches.create!(term: "example")
    allow(Search).to receive(:find_similar).and_return(similar_search)
    SearchTermCreateJob.perform_now(user_ip: user_ip, term: "example_updated")
    expect(similar_search.reload.term).to eq("example_updated")

    allow(Search).to receive(:find_similar).and_return(nil)
    SearchTermCreateJob.perform_now(user_ip: user_ip, term: "newterm")
    expect(user_ip.searches.where(term: "newterm")).to exist
  end
end
