const videojs = window.videojs;

document.addEventListener("DOMContentLoaded", () => {
  const videoElement = document.getElementById("daily-video");

  if (videoElement) {
    // Initialize Video.js
    const player = videojs(videoElement, {
      controls: true,
      autoplay: false,
      preload: "auto",
    });

    // Ensure Video.js is ready
    player.ready(() => {
      console.log("Video.js is ready!");

      // Add keyboard controls for frame-by-frame scrubbing
      document.addEventListener("keydown", (event) => {
        const currentTime = player.currentTime();
        const frameRate = 24; // Assuming 24 frames per second
        const frameDuration = 1 / frameRate;

        if (event.key === "ArrowRight") {
          // Advance by one frame
          const newTime = currentTime + frameDuration;
          player.currentTime(newTime);
          const frameNumber = Math.round(newTime * frameRate);
          console.log(`Forward to frame: ${frameNumber}`);
        } else if (event.key === "ArrowLeft") {
          // Go back by one frame
          const newTime = Math.max(0, currentTime - frameDuration);
          player.currentTime(newTime);
          const frameNumber = Math.round(newTime * frameRate);
          console.log(`Backward to frame: ${frameNumber}`);
        }
      });
    });
  } else {
    console.error("Video element not found.");
  }
});
