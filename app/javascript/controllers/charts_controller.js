import { Controller } from "stimulus"
import Chart from 'chart.js';
import { jsPDF } from "jspdf";

export default class extends Controller {
  static targets = [ "graphs", "period" ]

  connect() {
    this.initializePDF()

    JSON.parse(this.graphsTarget.dataset.value).forEach((graph) => {
      this.symptomTitlePDF(graph)
      this.displayChart(graph)
    })
    // this.doc.save("a4.pdf");
  }

  initializePDF() {
    this.doc = new jsPDF()
    this.row = 10
    this.doc.text(this.periodTarget.textContent, 10, this.row)
  }

  symptomTitlePDF(graph) {
    this.row = this.row + 20
    this.doc.text(graph['name'], 10, this.row)
    this.row = this.row + 10
  }

  symptomImagePDF(image) {
    // this.doc.text(image, 10, this.row)
  }

  toggle(e) {
    e.target.parentElement.classList.toggle("underline")
    const symptom = e.target.dataset.symptom
    const symptomChart = document.querySelector(`[data-symptom-target=${symptom}]`)
    symptomChart.classList.toggle("d-none")
  }

  resetFilters() {
    document.querySelectorAll("[data-symptom-target").forEach((target) => {
      if (target.classList.contains("d-none")) {
        target.classList.remove("d-none")
      }
    })
    const filterTitles = document.querySelectorAll("h3[data-symptom]")
    filterTitles.forEach((filter) => {
      if (!filter.classList.contains("underline")) {
        filter.parentElement.classList.add("underline")
      }
    })
  }

  displayChart(graph) {
    let graphDoc = this.doc
    var ctx = document.getElementById(`${graph["id"]}`).getContext('2d');
    Chart.defaults.global.defaultFontFamily = 'Lato';
    var chart = new Chart(ctx, {
      // The type of chart we want to create
      type: 'line',

      // The data for our dataset
      data: {
        labels: Array.from(graph['labels']),
        datasets: [{
          label: `${graph['name']}`,
          backgroundColor: 'transparent',
          borderColor: `${graph['border_color']}`,
          borderWidth: 4,
          data: Array.from(graph['data']),
          pointRadius: 6,
          pointHoverRadius: 6,
          pointBackgroundColor: '#EB7099',
          pointBorderWidth: 0,
          pointBorderColor: '#EB7099'
        }],
      },

      // Configuration options go here
      options: {
        animation: {
          onComplete: function() {
            document.getElementById(`img-${graph["id"]}`).src = chart.toBase64Image();
          }
        },
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          yAxes: [{
            display: true,
            ticks: {
                suggestedMax: `${graph["suggested_max"]}`,
                beginAtZero: true,
                stepSize: `${graph["step_size"]}`,
                fontColor: '#B9B9B9',
                padding: 10
            },
            gridLines: {
                borderDash: [5, 5]
            }
          }],
          xAxes: [{
            display: true,
            ticks: {
                fontColor: '#B9B9B9',
                padding: 5
            }
          }]
        },
        legend: {
          display: false
        }
      }
    });
  }
}
