import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static classes = ["compact"]

  connect() {
    this.onScroll = () => {
      this.element.classList.toggle(this.compactClass, window.scrollY > 24)
    }
    this.onScroll()
    window.addEventListener("scroll", this.onScroll, { passive: true })
  }

  disconnect() {
    window.removeEventListener("scroll", this.onScroll)
  }
}
