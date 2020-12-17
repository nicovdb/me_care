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
    doc.setTextColor(3,94,112);
    doc.setFont("Helvetica");
    doc.setFontSize(22);
    const width = parseInt(this.exportTarget.dataset.graphWidth, 10) / 4

    doc.text(this.periodTarget.textContent, 20, 20)
    doc.setFontSize(12);

    if (this.exportTarget.dataset["painChart"] != "data:,") {
      doc.text("Douleurs", 20, 30)
      doc.addImage(this.exportTarget.dataset["painChart"], "PNG", 20, 35, width, 37.5)
    }

    if (this.exportTarget.dataset["bloodChart"] != "data:,") {
      doc.text("Saignements", 20, 80)
      doc.addImage(this.exportTarget.dataset["bloodChart"], "PNG", 20, 85, width, 37.5)
    }

    if (this.exportTarget.dataset["digestiveTroubleChart"] != "data:,") {
      doc.text("Troubles digestifs", 20, 130)
      doc.addImage(this.exportTarget.dataset["digestiveTroubleChart"], "PNG", 20, 135, width, 37.5)
    }

    if (this.exportTarget.dataset["stressChart"] != "data:,") {
      doc.text("Stress", 20, 180)
      doc.addImage(this.exportTarget.dataset["stressChart"], "PNG", 20, 185, width, 37.5)
    }

    if (this.exportTarget.dataset["insomniaChart"] != "data:,") {
      doc.text("Insomnie", 20, 230)
      doc.addImage(this.exportTarget.dataset["insomniaChart"], "PNG", 20, 235, width, 37.5)
    }

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
