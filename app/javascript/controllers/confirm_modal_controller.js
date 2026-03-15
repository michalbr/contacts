import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["backdrop", "resource", "resourceName", "deleteButton"]

  open(event) {
    event.preventDefault()
    this.resourceNameTarget.textContent = event.params.resourceName
    this.resourceTarget.textContent = event.params.resource
    this.deleteButtonTarget.closest("form").action = event.params.resourcePath
    this.backdropTarget.classList.remove("hidden")
  }

  close(event) {
    event.stopPropagation()
    this.backdropTarget.classList.add("hidden")
  }

  closeOnBackdrop(event) {
    if (event.target === this.backdropTarget) this.close(event)
  }
}