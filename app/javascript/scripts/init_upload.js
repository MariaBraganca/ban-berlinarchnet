const initUpload = () => {
  // UPLOAD COVER/USER PHOTO
  const inputCover = document.querySelectorAll(".form-control-file")[0];
  
  if(inputCover) {
    inputCover.style.display = "none";
    
    const labelCover = document.querySelector("label.file.label-cover");
    if(labelCover) {
      labelCover.innerHTML = "<i class='fas fa-image fa-lg mr-2'></i>Upload cover photo";
      labelCover.classList.add("btn", "btn-upload", "w-100", "mb-0");
    }
    
    const labelUser = document.querySelector("label.file.label-user");
    if(labelUser) {
      labelUser.innerHTML = "<i class='fas fa-user fa-lg mr-2'></i>Upload your photo";
      labelUser.classList.add("btn", "btn-upload", "w-100", "mb-0");
    }

    inputCover.addEventListener("change", handleFiles, false); 
    function handleFiles() {
      if(inputCover.files.length === 0) {
        if(labelUser) {
          labelUser.innerHTML = "<i class='fas fa-user fa-lg mr-2'></i>Upload your photo";
        } else {
          labelCover.innerHTML = "<i class='fas fa-image fa-lg mr-2'></i>Upload cover photo";
        }
      } else {
        if(labelUser) {
          labelUser.innerHTML = `<i class='fas fa-user fa-lg mr-2'></i> ${inputCover.files[0]["name"]}`;
        } else {
          labelCover.innerHTML = `<i class='fas fa-image fa-lg mr-2'></i> ${inputCover.files[0]["name"]}`;
        }        
      }
    };
  }
  // UPLOAD MORE PHOTOS/PROJECTS
  const inputPhotos = document.querySelectorAll(".form-control-file")[1];
  
  if(inputPhotos) {
    inputPhotos.style.display = "none";
    
    const labelPhotos = document.querySelector("label.file.label-photos");
    if(labelPhotos) {
      labelPhotos.innerHTML = "<i class='fas fa-images fa-lg mr-2'></i>Upload more photos";
      labelPhotos.classList.add("btn", "btn-upload", "w-100", "mb-0");
    }
  
    const labelProjects = document.querySelector("label.file.label-projects");
    if(labelProjects) {
      labelProjects.innerHTML = "<i class='fas fa-images fa-lg mr-2'></i>Upload your projects";
      labelProjects.classList.add("btn", "btn-upload", "w-100", "mt-3");
    }

    inputPhotos.addEventListener("change", handleFiles, false); 
    function handleFiles() {
      if(inputPhotos.files.length === 0) {
        if(labelProjects) {
          labelProjects.innerHTML = "<i class='fas fa-images fa-lg mr-2'></i>Upload your projects";
        } else {
          labelPhotos.innerHTML = "<i class='fas fa-images fa-lg mr-2'></i>Upload more photos";
        }
      } else {
        if(labelProjects) {
          labelProjects.innerHTML = `<i class='fas fa-images fa-lg mr-2'></i></i> ${inputPhotos.files.length} projects selected;`;
        } else {
          labelPhotos.innerHTML = `<i class='fas fa-images fa-lg mr-2'></i></i> ${inputPhotos.files.length} photos selected;`;
        }        
      }
    };
  }
};

export { initUpload };