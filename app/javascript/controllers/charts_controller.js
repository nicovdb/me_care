import { Controller } from "stimulus"
import Chart from 'chart.js';
import { jsPDF } from "jspdf";

export default class extends Controller {
  static targets = [ "graphs", "period", "export" ]

  connect() {
    JSON.parse(this.graphsTarget.dataset.value).forEach((graph) => {
      this.displayChart(graph)
    })
    // enlever si changmeent d'avis
    this.filteredValue = false
  }

  downloadPDF() {
    const doc = new jsPDF()
    doc.setTextColor(3,94,112);
    doc.setFont("Helvetica");
    doc.setFontSize(22);
    const width = parseInt(this.exportTarget.dataset.graphWidth, 10) / 4

    const convertDate = () => {
      const date = Date.now();
      const year = new Intl.DateTimeFormat('en', { year: 'numeric' }).format(date);
      const month = new Intl.DateTimeFormat('en', { month: '2-digit' }).format(date);
      const day = new Intl.DateTimeFormat('en', { day: '2-digit' }).format(date);
      return `${day} ${month} ${year}`;
    };

    const dataImg = "data:image/png;base64,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";

    doc.addImage(dataImg, "PNG", 140, 20, 50, 12);

    doc.setFontSize(12);
    doc.text("Export fait le " + convertDate(), 20, 20)

    doc.setFontSize(22);
    doc.text(this.periodTarget.textContent, 20, 30);

    doc.setFontSize(12);


    if (this.exportTarget.dataset["painChart"] != "data:,") {
      doc.text("Douleurs", 20, 40)
      doc.addImage(this.exportTarget.dataset["painChart"], "PNG", 20, 45, width, 37.5)
    }

    if (this.exportTarget.dataset["bloodChart"] != "data:,") {
      doc.text("Saignements", 20, 90)
      doc.addImage(this.exportTarget.dataset["bloodChart"], "PNG", 20, 95, width, 37.5)
    }

    if (this.exportTarget.dataset["digestiveTroubleChart"] != "data:,") {
      doc.text("Troubles digestifs", 20, 140)
      doc.addImage(this.exportTarget.dataset["digestiveTroubleChart"], "PNG", 20, 145, width, 37.5)
    }

    if (this.exportTarget.dataset["stressChart"] != "data:,") {
      doc.text("Stress", 20, 190)
      doc.addImage(this.exportTarget.dataset["stressChart"], "PNG", 20, 195, width, 37.5)
    }

    if (this.exportTarget.dataset["insomniaChart"] != "data:,") {
      doc.text("Insomnie", 20, 240)
      doc.addImage(this.exportTarget.dataset["insomniaChart"], "PNG", 20, 245, width, 37.5)
    }

    doc.save(`${this.periodTarget.textContent}.pdf`);
  }

  toggle(e) {
    // enlever si changement d'avis
    if (this.filteredValue == false) {
      this.hideAll()
      this.filteredValue = true
    }

    e.target.parentElement.classList.toggle("underline")
    const symptom = e.target.dataset.symptom
    const symptomChart = document.querySelector(`[data-symptom-target=${symptom}]`)
    symptomChart.classList.toggle("d-none")
  }

  // enlever
  hideAll() {
    document.querySelectorAll("[data-symptom-target").forEach((target) => {
      console.log(target)
      if (!target.classList.contains("d-none")) {
        target.classList.add("d-none")
      }
    })
  }

  resetFilters() {
    document.querySelectorAll("[data-symptom-target").forEach((target) => {
      if (target.classList.contains("d-none")) {
        target.classList.remove("d-none")
      }
    })
    const filterTitles = document.querySelectorAll("h3[data-symptom]")
    filterTitles.forEach((filter) => {
      // Mettre l'inverse si changement d'avis
      if (filter.parentElement.classList.contains("underline")) {
        filter.parentElement.classList.remove("underline")
      }
    })
    // enlever
    this.filteredValue = false
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
