const videojs = window.videojs;

document.addEventListener("DOMContentLoaded", () => {
  const videoElement = document.getElementById("daily-video");
  const timestampField = document.querySelector("input#revision_timestamp"); // Timestamp field
  const grabTimestampButton = document.getElementById("grab-timestamp"); // Button for manual timestamp capture
  const frameRate = 24; // Assuming 24 frames per second for NTSC

  if (videoElement) {
    // Initialize Video.js
    const player = videojs(videoElement, {
      controls: true,
      autoplay: false,
      preload: "auto",
    });

    // Format time in NTSC format: HH:MM:SS:FF
    const formatToNTSC = (timeInSeconds) => {
      const totalFrames = Math.round(timeInSeconds * frameRate);
      const hours = Math.floor(totalFrames / (3600 * frameRate));
      const minutes = Math.floor((totalFrames % (3600 * frameRate)) / (60 * frameRate));
      const seconds = Math.floor((totalFrames % (60 * frameRate)) / frameRate);
      const frames = totalFrames % frameRate;

      return [
        String(hours).padStart(2, "0"),
        String(minutes).padStart(2, "0"),
        String(seconds).padStart(2, "0"),
        String(frames).padStart(2, "0"),
      ].join(":");
    };

    player.ready(() => {
      console.log("Video.js is ready!");

      // Add keyboard controls for frame-by-frame scrubbing
      document.addEventListener("keydown", (event) => {
        const currentTime = player.currentTime();
        const frameDuration = 1 / frameRate;

        if (event.key === "ArrowRight") {
          // Advance by one frame
          const newTime = currentTime + frameDuration;
          player.currentTime(newTime);
          const frameNumber = Math.round(newTime * frameRate);
          console.log(`Moved forward to frame: ${frameNumber}`);
        } else if (event.key === "ArrowLeft") {
          // Go back by one frame
          const newTime = Math.max(0, currentTime - frameDuration);
          player.currentTime(newTime);
          const frameNumber = Math.round(newTime * frameRate);
          console.log(`Moved backward to frame: ${frameNumber}`);
        }
      });

      // Auto-fill the timestamp field in NTSC format when video is paused
      player.on("pause", () => {
        if (timestampField) {
          const currentTime = player.currentTime();
          const ntscTimestamp = formatToNTSC(currentTime);
          timestampField.value = ntscTimestamp;
          console.log(`Timestamp auto-filled: ${ntscTimestamp}`);
        }
      });

      // Manual timestamp capture using the button
      if (grabTimestampButton) {
        grabTimestampButton.addEventListener("click", () => {
          if (timestampField) {
            const currentTime = player.currentTime();
            const ntscTimestamp = formatToNTSC(currentTime);
            timestampField.value = ntscTimestamp;
            console.log(`Timestamp manually set to: ${ntscTimestamp}`);
          }
        });
      }
    });
  } else {
    console.error("Video element not found.");
  }
});
