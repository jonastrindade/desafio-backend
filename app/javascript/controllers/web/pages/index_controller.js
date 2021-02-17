import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "main" ]

  connect() {
    console.log('Pages!')
    this.getCongressPersons()
    this.getCongressPersonExpenses()
    this.getCongressPersonsCalculations()
  }

  getCongressPersons() {
    // var data = { partner: { clinic_id: this.application.clinic.id }, current_user: { current_user_id: this.application.current_user_id } }
    // console.log(data)
    const token = $('meta[name=csrf-token]').attr('content');
    const url = "/congress_persons/entities"
    const init = { method: "GET", credentials: "same-origin", headers: { "X-CSRF-Token": token, 'Content-Type': 'application/json' } }
    fetch(url, init)
      .then(response => response.json())
      .then(response => {
        console.log(response)
      })
      .catch(error => {
        console.log(error)
      })
  }

  getCongressPersonExpenses() {
    // var data = { partner: { clinic_id: this.application.clinic.id }, current_user: { current_user_id: this.application.current_user_id } }
    // console.log(data)
    const token = $('meta[name=csrf-token]').attr('content');
    const url = "/congress_persons/expenses"
    const init = { method: "GET", credentials: "same-origin", headers: { "X-CSRF-Token": token, 'Content-Type': 'application/json' } }
    fetch(url, init)
      .then(response => response.json())
      .then(response => {
        console.log(response)
      })
      .catch(error => {
        console.log(error)
      })
  }

  getCongressPersonsCalculations() {
    // var data = { partner: { clinic_id: this.application.clinic.id }, current_user: { current_user_id: this.application.current_user_id } }
    // console.log(data)
    const token = $('meta[name=csrf-token]').attr('content');
    const url = "/congress_persons/calculations"
    const init = { method: "GET", credentials: "same-origin", headers: { "X-CSRF-Token": token, 'Content-Type': 'application/json' } }
    fetch(url, init)
      .then(response => response.json())
      .then(response => {
        console.log(response)
      })
      .catch(error => {
        console.log(error)
      })
  }

}
