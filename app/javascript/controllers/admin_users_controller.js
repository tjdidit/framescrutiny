document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("add-user-form");
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
        alert(`User created successfully! Temporary password: ${data.password}`);
        window.location.reload(); // Reload to reflect new user
      } else {
        const errorData = await response.json();
        alert(`Failed to create user: ${errorData.errors.join(", ")}`);
      }
    } catch (error) {
      console.error("Error creating user:", error);
      alert("An error occurred while creating the user.");
    }
  });
});
