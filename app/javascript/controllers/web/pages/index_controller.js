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

  // buscamos todos uploads ja realizados na api uploads
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
  // buscamos todos deputados ja cadstrados na api de deputados
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

  // buscamos todas analise de dados ja cadstrados na api de analise de dados
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

  // buscamos todas despesas ja cadstrados na api de despesas
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

  // geramos o html das despesas
  doUploadsHtml() {
    this.mainTarget.innerHTML =  ``
    var linesHtml = ``
    this.uploads.files.forEach(element => {

      if (element.year == 'null') {
        var year = 'NA'
      } else {
        var year = element.year
      }

      linesHtml += `<tr>
                    <td>${year}</td>
                    <td><button id="${element.id}" data-action="click->web--pages--index#doHtmlCongressPersons" class="btn btn-light">Deputados</button></td>
                  </tr>`
    });

    var tableHtml = `<table class="table mt-3">
                      <thead>
                        <tr>
                          <th scope="col">Ano</th>
                          <th scope="col">Deputados</th>
                        </tr>
                      </thead>
                      <tbody>
                        ${linesHtml}
                      </tbody>
                    </table>`

    this.mainTarget.innerHTML = tableHtml
  }

  // geramos o html dos deputados 
  doHtmlCongressPersons(ev) {
    this.mainTarget.innerHTML =  ``
    var linesHtml = ``
    this.congressPersons.congress_persons.forEach(element => {
      if (element.uploads_id == ev.target.id) {
        linesHtml += `<tr>
                      <td>${element.name}</td>
                      <td>${element.party}</td>
                      <td>${element.registration_id}</td>
                      <td><button id="${element.id}" data-action="click->web--pages--index#doHtmlCongressPersonsExpenses" class="btn btn-light">Gastos</button></td>
                    </tr>`
      }
    });

    var tableHtml = `<table class="table mt-3">
                      <thead>
                        <tr>
                          <th scope="col">Nome</th>
                          <th scope="col">Partido</th>
                          <th scope="col">Número de Registro</th>
                          <th scope="col">Gastos</th>
                        </tr>
                      </thead>
                      <tbody>
                        ${linesHtml}
                      </tbody>
                    </table>`

    this.mainTarget.innerHTML = tableHtml
  }

  // geramos o html das despesas por deputados + analise de dados 
  doHtmlCongressPersonsExpenses(ev) {
    console.log(this.congressPersonsCalculations.calculations)
    this.mainTarget.innerHTML =  ``
    var linesHtml = ``
    var cardsHtml = ``

    this.congressPersonsCalculations.calculations.forEach(element => {
      if (element.congress_person_entities_id == ev.target.id) {
        cardsHtml += `<div class="card bg-light mb-3" style="max-width: 18rem;">
                        <div class="card-header">Soma dos gastos</div>
                        <div class="card-body">
                          <h5 class="card-title">R$ ${Number(element.net_value_sum).toFixed(2)}</h5>
                        </div>
                      </div>
                      <div class="card bg-light mb-3" style="max-width: 18rem;">
                        <div class="card-header">Maior gasto</div>
                        <div class="card-body">
                          <h5 class="card-title">R$ ${Number(element.net_value_max).toFixed(2)}</h5>
                        </div>
                      </div>
                      <div class="card bg-light mb-3" style="max-width: 18rem;">
                        <div class="card-header">Menor Gasto</div>
                        <div class="card-body">
                          <h5 class="card-title">R$ ${Number(element.net_value_min).toFixed(2)}</h5>
                        </div>
                      </div>`
      }
    });
    
    this.congressPersonsExpenses.expenses.forEach(element => {
      if (element.congress_person_entities_id == ev.target.id) {
        linesHtml += `<tr>
                      <td>${element.issue_date}</td>
                      <td>${element.provider}</td>
                      <td>R$ ${Number(element.net_value).toFixed(2)}</td>
                      <td><a href="${element.document_url}" target="_blank">Link</a></td>
                    </tr>`
      }
    });

    var tableHtml = `<div class="mt-3 card-deck justify-content-center">
                      ${cardsHtml}                      
                    </div>
                    <table class="table">
                      <thead>
                        <tr>
                          <th scope="col">Data de Emissão</th>
                          <th scope="col">Fornecedor</th>
                          <th scope="col">Valor líquido</th>
                          <th scope="col">Url do documento</th>
                        </tr>
                      </thead>
                      <tbody>
                        ${linesHtml}
                      </tbody>
                    </table>`

    this.mainTarget.innerHTML = tableHtml

  }

  update(){
    
  }

}
