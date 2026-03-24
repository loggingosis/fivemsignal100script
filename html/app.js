window.addEventListener('message', function (event) {
    const data = event.data;
    const audio = document.getElementById('signal100Audio');

    if (!audio) return;

    if (data.action === 'play') {
        audio.pause();
        audio.currentTime = 0;
        audio.volume = 1.0;

        const promise = audio.play();
        if (promise !== undefined) {
            promise.catch(() => {});
        }
    }

    if (data.action === 'stop') {
        audio.pause();
        audio.currentTime = 0;
    }
});
