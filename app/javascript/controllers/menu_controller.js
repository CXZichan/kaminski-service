import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "button"]

  connect() {
    this.handleKeydown = (event) => {
      if (event.key === "Escape" && this.open) this.close()
    }
  }

  toggle() {
    this.open ? this.close() : this.show()
  }

  show() {
    this.open = true
    this.panelTarget.classList.add("is-open")
    this.buttonTarget.setAttribute("aria-expanded", "true")
    document.body.classList.add("menu-open")
    document.addEventListener("keydown", this.handleKeydown)
    this.panelTarget.querySelector("a")?.focus()
  }

  close() {
    this.open = false
    this.panelTarget.classList.remove("is-open")
    this.buttonTarget.setAttribute("aria-expanded", "false")
    document.body.classList.remove("menu-open")
    document.removeEventListener("keydown", this.handleKeydown)
    this.buttonTarget.focus()
  }
}
