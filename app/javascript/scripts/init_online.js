const initOnline = () => {
  // Choose between an online or presencial event
  const onlineEvent = document.querySelector("#event_online");

  if(onlineEvent) {
    // default state
    if(onlineEvent.checked) {
      document.querySelector(".event_location").style.display = "none";
      document.querySelector(".event_venue").style.display = "none";
      document.querySelector(".event_online_link").style.display = "block";
      document.querySelector("#event_location").value = "";
      document.querySelector("#event_venue").value = "";
    } else {
      document.querySelector(".event_location").style.display = "block";
      document.querySelector(".event_venue").style.display = "block";
      document.querySelector(".event_online_link").style.display = "none";
    } 
    // on click of event online checkbox
    onlineEvent.addEventListener("click", (event) => {
      if(onlineEvent.checked) {
        document.querySelector(".event_location").style.display = "none";
        document.querySelector(".event_venue").style.display = "none";
        document.querySelector(".event_online_link").style.display = "block";
        document.querySelector("#event_location").value = "";
        document.querySelector("#event_venue").value = "";
        document.querySelector("#event_online_link").value = "";
      } else {
        document.querySelector(".event_location").style.display = "block";
        document.querySelector(".event_venue").style.display = "block";
        document.querySelector(".event_online_link").style.display = "none";
      }     
    });
  }

};

export { initOnline };