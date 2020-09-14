const navbarMenu = () => {
  const menuBurger = document.getElementById("menu-burger");
  const menuClose = document.getElementById("menu-close");
  const menu = document.getElementById("menu");

  if (menuBurger && menuClose && menu) {
    menuBurger.addEventListener("click", (e) => {
      menu.classList.toggle("visible");
      menu.classList.toggle("close");
      menu.scrollTo(0, 0);
    })

    menuClose.addEventListener("click", (e) => {
      menu.classList.toggle("visible");
      menu.classList.toggle("close");
    })
  }
}

export { navbarMenu }
