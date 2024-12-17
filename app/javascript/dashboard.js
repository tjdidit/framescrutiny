document.addEventListener("DOMContentLoaded", () => {
  console.log("Dashboard.js loaded");

  // Select the modal form and feedback area
  const modalForm = document.getElementById("add-user-form");
  const feedback = document.getElementById("password-feedback");

  if (!modalForm || !feedback) {
    console.log("Modal form or feedback area not found!");
    return;
  }

  // Listen for the form's submit event
  modalForm.addEventListener("submit", async (event) => {
    console.log("JavaScript intercepted the form submission");
    event.preventDefault(); // Prevent the browser's default form submission

    const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");

    const userData = {
      user: {
        username: modalForm.querySelector("#username").value,
        email: modalForm.querySelector("#email").value,
        role: modalForm.querySelector("#role").value,
      },
    };

    try {
      const response = await fetch("/dashboard/create_user", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken,
        },
        body: JSON.stringify(userData),
      });

      if (response.ok) {
        const data = await response.json();
        console.log("User created successfully:", data);

        // Show success feedback in the UI
        feedback.innerHTML = `
          <div class="alert alert-success">
            User created successfully! Temporary password: <strong>${data.password}</strong>
          </div>
        `;

        // Optionally reset the form fields
        modalForm.reset();
      } else {
        const errorData = await response.json();
        console.error("Error creating user:", errorData);

        feedback.innerHTML = `
          <div class="alert alert-danger">
            Failed to create user: ${errorData.errors.join(", ")}
          </div>
        `;
      }
    } catch (error) {
      console.error("Fetch error:", error);

      feedback.innerHTML = `
        <div class="alert alert-danger">
          An error occurred while creating the user.
        </div>
      `;
    }
  }); // Closing the submit event listener
}); // Closing the DOMContentLoaded listener

document.addEventListener("DOMContentLoaded", () => {
  const projectForm = document.getElementById("create-project-form");

  projectForm.addEventListener("submit", async (event) => {
    event.preventDefault(); // Prevent default form submission

    const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");

    const projectData = {
      project: {
        name: document.getElementById("projectName").value,
        description: document.getElementById("projectDescription").value,
      },
    };

    try {
      const response = await fetch("/projects", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken,
        },
        body: JSON.stringify(projectData),
      });

      if (response.ok) {
        const data = await response.json();
        console.log("Project created successfully:", data);

        // Ensure project list exists
        let projectList = document.getElementById("project-list");
        if (!projectList) {
          // Create the list if it doesn't exist
          projectList = document.createElement("ul");
          projectList.id = "project-list";
          document.querySelector("body").appendChild(projectList); // Adjust parent element as needed
        }

        // Dynamically add the new project to the list
        const newProject = document.createElement("li");
        newProject.textContent = `${data.name}: ${data.description}`;
        projectList.appendChild(newProject);

        // Optionally reset the form
        projectForm.reset();
      } else {
        const errorData = await response.json();
        console.error("Error creating project:", errorData);
      }
    } catch (error) {
      console.error("Fetch error:", error);
    }
  });
});
