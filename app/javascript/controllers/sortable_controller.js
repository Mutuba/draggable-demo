import { Controller } from "@hotwired/stimulus";
import { Sortable } from "@shopify/draggable";
import Rails from "@rails/ujs";

export default class extends Controller {
  static values = {
    url: String,
  };

  connect() {
    this.sortable = new Sortable(this.element, {
      draggable: this.element.dataset.sortableDraggableClass || ".todo-item",
      handle: this.element.dataset.sortableHandleClass || ".handle",
    });

    this.sortable.on("drag:stopped", () => {
      this.updateOrder();
    });
  }

  updateOrder() {
    let items = Array.from(this.element.querySelectorAll(".todo-item"));
    let order = items.map((item, index) => ({
      id: item.dataset.id,
      position: index + 1,
    }));

    Rails.ajax({
      url: this.urlValue,
      type: "PATCH",
      data: { todos: order },
      dataType: "json",
      beforeSend: (xhr, options) => {
        if (options.dataType === "json") {
          xhr.setRequestHeader("Content-Type", "application/json");
          if (typeof options.data !== "undefined") {
            options.data = JSON.stringify(options.data);
          }
        }
        return true;
      },
    });
  }
}
