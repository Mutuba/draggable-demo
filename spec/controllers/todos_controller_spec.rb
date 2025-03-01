require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  describe "#index" do
    subject(:index_request) { get :index }

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

  describe "#show" do
    subject(:show_request) { get :show, params: { id: todo.id } }

    let(:todo) { create(:todo) }

    before { show_request }

    it "returns a success response" do
      expect(response).to have_http_status(:success)
    end

    it "assigns the requested todo to @todo" do
      expect(assigns(:todo)).to eq(todo)
    end

    it "renders the show template" do
      expect(response).to render_template(:show)
    end
  end

  describe "#create" do
    subject(:create_request) { post :create, params: create_params }

    context "when valid params" do
      let(:create_params) { { todo: { title: "Awesome title", description: "Awesome description" } } }

      it "creates a todo" do
        expect { create_request }.to change(Todo, :count).by(1)
        # expect { create_request }.to change { Todo.count }.by 1
      end
    end

    context "when invalid params" do
      let(:create_params) { { todo: { title: "", description: "" } } }

      it "does not create a todo" do
        expect { create_request }.not_to change(Todo, :count)
      end
    end
  end

  describe "#edit" do
    subject(:edit_request) { get :edit, params: { id: todo.id } }

    let(:todo) { create(:todo) }

    before { edit_request }

    it "returns a success response" do
      expect(response).to have_http_status(:success)
    end

    it "assigns the requested todo to @todo" do
      expect(assigns(:todo)).to eq(todo)
    end

    it "renders the edit template" do
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    subject(:update_request) { patch :update, params: update_params }

    let(:todo) { create(:todo, title: "Old Title") }

    context "when valid params" do
      let(:update_params) { { id: todo.id, todo: { title: "New Title" } } }

      it "updates the todo" do
        update_request
        expect(todo.reload.title).to eq("New Title")
      end

      it "redirects to the updated todo" do
        update_request
        expect(response).to redirect_to(todo)
      end
    end

    context "when invalid params" do
      let(:update_params) { { id: todo.id, todo: { title: "" } } }

      it "does not update the todo" do
        update_request
        expect(todo.reload.title).to eq("Old Title")
      end

      it "renders the edit template" do
        update_request
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "#destroy" do
    subject(:destroy_request) { delete :destroy, params: { id: todo.id } }

    let!(:todo) { create(:todo) }

    it "deletes the todo" do
      expect { destroy_request }.to change(Todo, :count).by(-1)
    end

    it "redirects to the todos list" do
      destroy_request
      expect(response).to redirect_to(todos_path)
    end
  end

  describe "#sort" do
    subject(:sort_request) { post :sort, params: { todos: sorted_params } }

    let!(:todo1) { create(:todo, id: 1, order_priority: 1, title: "Random title") }
    let!(:todo2) { create(:todo, id: 2, order_priority: 2, title: "Random title") }

    let(:sorted_params) do
      [
        { id: todo2.id, position: 1, title: "Awesome title" },
        { id: todo1.id, position: 2, title: "Awesome title" }
      ]
    end

    it "updates order_priority of todos" do
      sort_request
      expect(todo1.reload.order_priority).to eq(2)
      expect(todo2.reload.order_priority).to eq(1)
    end

    it "returns a success response" do
      sort_request
      expect(response).to have_http_status(:ok)
    end
  end
end

