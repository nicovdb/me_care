const imcCalculation = () => {
  const size = document.getElementById('information_size');
  const weight = document.getElementById('information_weight');
  if (size && weight) {
    const size_weight = [size , weight];
    const imc = document.getElementById('information_imc');
    size_weight.forEach((element) => {
      element.addEventListener("keyup", (event) => {
        const num = weight.value / Math.pow(size.value / 100, 2);
        imc.value = Math.round(num * 100) / 100;
      });
    });
  };
};


export { imcCalculation }
