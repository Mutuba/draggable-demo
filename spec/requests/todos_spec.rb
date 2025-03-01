require 'rails_helper'

RSpec.describe "Todo", type: :request do
  describe "GET #index" do
    subject(:index_request) { get todos_path }

    let!(:todo1) { create(:todo, order_priority: 1) }
    let!(:todo2) { create(:todo, order_priority: 2) }

    before { index_request } 

    it "returns a success response" do
      expect(response).to have_http_status(:success)
    end

    it "assigns @todos sorted by order_priority" do
      expect(assigns(:todos)).to eq([todo1, todo2])
    end

    it "renders the index template" do
      expect(response).to render_template(:index)
    end
  end
end

