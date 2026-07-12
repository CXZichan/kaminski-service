import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.querySelectorAll("details").forEach((details) => {
      details.addEventListener("toggle", () => {
        if (!details.open) return
        this.element.querySelectorAll("details[open]").forEach((other) => {
          if (other !== details) other.removeAttribute("open")
        })
      })
    })
  }
}
