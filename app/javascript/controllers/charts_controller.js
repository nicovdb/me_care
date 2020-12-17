import { Controller } from "stimulus"
import Chart from 'chart.js';
import { jsPDF } from "jspdf";

export default class extends Controller {
  static targets = [ "graphs", "period", "export" ]

  connect() {
    JSON.parse(this.graphsTarget.dataset.value).forEach((graph) => {
      this.displayChart(graph)
    })
  }

  downloadPDF() {
    const doc = new jsPDF()
    const width = parseInt(this.exportTarget.dataset.graphWidth, 10) / 4

    doc.text(this.periodTarget.textContent, 10, 10)

    doc.text("Douleurs", 10, 30)
    doc.addImage(this.exportTarget.dataset["painChart"], "PNG", 10, 35, width, 37.5)

    doc.text("Saignements", 10, 80)
    doc.addImage(this.exportTarget.dataset["bloodChart"], "PNG", 10, 85, width, 37.5)

    doc.text("Troubles digestifs", 10, 130)
    doc.addImage(this.exportTarget.dataset["digestiveTroubleChart"], "PNG", 10, 135, width, 37.5)

    doc.text("Stress", 10, 180)
    doc.addImage(this.exportTarget.dataset["stressChart"], "PNG", 10, 185, width, 37.5)

    doc.text("Insomnie", 10, 230)
    doc.addImage(this.exportTarget.dataset["insomniaChart"], "PNG", 10, 235, width, 37.5)

    doc.save(`${this.periodTarget.textContent}.pdf`);
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
            document.getElementById("data-export").dataset["graphWidth"] = chart.canvas.style.width.slice(0, -2);
            document.getElementById("data-export").dataset[graph["id"]] = chart.toBase64Image();
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
