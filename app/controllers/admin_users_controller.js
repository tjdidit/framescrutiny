document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("add-user-form");
  const feedback = document.getElementById("password-feedback"); // Element to show the password
  const modal = new bootstrap.Modal(document.getElementById("addUserModal")); // Bootstrap modal instance

  if (!form || !feedback) return;

  form.addEventListener("submit", async (event) => {
    event.preventDefault();

    const formData = new FormData(form);
    const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");

    try {
      const response = await fetch("/admin/users", {
        method: "POST",
        headers: {
          "X-CSRF-Token": csrfToken,
          Accept: "application/json",
        },
        body: formData,
      });

      if (response.ok) {
        const data = await response.json();

        // Display the password in the modal
        feedback.innerHTML = `
          <div class="alert alert-success">
            User created successfully! Temporary password: <strong>${data.password}</strong>
          </div>
        `;

        // Optionally, reset the form
        form.reset();
      } else {
        const errorData = await response.json();
        feedback.innerHTML = `
          <div class="alert alert-danger">
            Failed to create user: ${errorData.errors.join(", ")}
          </div>
        `;
      }
    } catch (error) {
      console.error("Error creating user:", error);
      feedback.innerHTML = `
        <div class="alert alert-danger">
          An error occurred while creating the user.
        </div>
      `;
    }
  });
});
