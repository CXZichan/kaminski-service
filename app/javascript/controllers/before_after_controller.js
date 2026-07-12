import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["after", "slider"]

  connect() {
    this.update()
  }

  update() {
    this.afterTarget.style.clipPath = `inset(0 ${100 - Number(this.sliderTarget.value)}% 0 0)`
  }

  keys(event) {
    if (!["ArrowLeft", "ArrowRight"].includes(event.key)) return
    const direction = event.key === "ArrowRight" ? 1 : -1
    this.sliderTarget.value = Math.max(0, Math.min(100, Number(this.sliderTarget.value) + direction * 5))
    this.update()
  }
}
