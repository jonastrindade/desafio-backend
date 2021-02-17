import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "main" ]

  connect() {
    console.log('Pages!')
    this.getUploads()
    this.getCongressPersons()
    this.getCongressPersonsCalculations()
    this.getCongressPersonExpenses()
  }

  getUploads() {
    var controller = this
    const token = $('meta[name=csrf-token]').attr('content');
    const url = "/uploads"
    const init = { method: "GET", credentials: "same-origin", headers: { "X-CSRF-Token": token, 'Content-Type': 'application/json' } }
    fetch(url, init)
      .then(response => response.json())
      .then(response => {
        this.uploads = response
        controller.doUploadsHtml()
        
      })
      .catch(error => {
        console.log(error)
      })
  }

  getCongressPersons() {
    const token = $('meta[name=csrf-token]').attr('content');
    const url = "/congress_persons/entities"
    const init = { method: "GET", credentials: "same-origin", headers: { "X-CSRF-Token": token, 'Content-Type': 'application/json' } }
    fetch(url, init)
      .then(response => response.json())
      .then(response => {
        this.congressPersons = response 
      })
      .catch(error => {
        console.log(error)
      })
  }

  getCongressPersonsCalculations() {
    const token = $('meta[name=csrf-token]').attr('content');
    const url = "/congress_persons/calculations"
    const init = { method: "GET", credentials: "same-origin", headers: { "X-CSRF-Token": token, 'Content-Type': 'application/json' } }
    fetch(url, init)
      .then(response => response.json())
      .then(response => {
        this.congressPersonsCalculations = response
      })
      .catch(error => {
        console.log(error)
      })
  }

  getCongressPersonExpenses() {
    const token = $('meta[name=csrf-token]').attr('content');
    const url = "/congress_persons/expenses"
    const init = { method: "GET", credentials: "same-origin", headers: { "X-CSRF-Token": token, 'Content-Type': 'application/json' } }
    fetch(url, init)
      .then(response => response.json())
      .then(response => {
        this.congressPersonsExpenses = response
      })
      .catch(error => {
        console.log(error)
      })
  }

  doUploadsHtml() {
    this.mainTarget.innerHTML =  ``
    var lineHtml = ``
    this.uploads.files.forEach(element => {

      lineHtml += `<tr>
                    <td>${element.year}</td>
                    <td><button id="${element.id}" data-action="click->web--pages--index#doHtmlCongressPersons" class="btn btn-light">Deputados</button></td>
                  </tr>`
    });

    var tableHtml = `<table class="table mt-5">
                      <thead>
                        <tr>
                          <th scope="col">Ano</th>
                          <th scope="col">Deputados</th>
                        </tr>
                      </thead>
                      <tbody>
                        ${lineHtml}
                      </tbody>
                    </table>`

    this.mainTarget.innerHTML = tableHtml
  }

  doHtmlCongressPersons(ev) {
    console.log(this.congressPersons.congress_persons)
    console.log(ev.target.id)
    this.mainTarget.innerHTML =  ``
    var lineHtml = ``
    this.congressPersons.congress_persons.forEach(element => {
      if (element.uploads_id == ev.target.id) {
        lineHtml += `<tr>
                      <td>${element.name}</td>
                      <td>${element.party}</td>
                      <td>${element.party}</td>
                      <td><button id="${element.id}" data-action="click->web--pages--index#doHtmlCongressPersonsExpenses" class="btn btn-light">Gastos</button></td>
                    </tr>`
      }
    });

    var tableHtml = `<table class="table">
                      <thead>
                        <tr>
                          <th scope="col">Nome</th>
                          <th scope="col">Partido</th>
                          <th scope="col">Id Doc</th>
                          <th scope="col">Gastos</th>
                        </tr>
                      </thead>
                      <tbody>
                        ${lineHtml}
                      </tbody>
                    </table>`

    this.mainTarget.innerHTML = tableHtml
  }

  doHtmlCongressPersonsExpenses(ev) {
    console.log(this.congressPersonsExpenses.expenses)
    console.log(ev.target.id)
    this.mainTarget.innerHTML =  ``
    var lineHtml = ``
    this.congressPersonsExpenses.expenses.forEach(element => {
      if (element.congress_person_entities_id == ev.target.id) {
        lineHtml += `<tr>
                      <td>${element.issue_date}</td>
                      <td>${element.provider}</td>
                      <td>${element.net_value}</td>
                      <td>${element.document_url}</td>
                    </tr>`
      }
    });

    var tableHtml = `<table class="table">
                      <thead>
                        <tr>
                          <th scope="col">Data de Emissão</th>
                          <th scope="col">Fornecedor</th>
                          <th scope="col">Valor líquido</th>
                          <th scope="col">Url do documento</th>
                        </tr>
                      </thead>
                      <tbody>
                        ${lineHtml}
                      </tbody>
                    </table>`

    this.mainTarget.innerHTML = tableHtml

  }

}
