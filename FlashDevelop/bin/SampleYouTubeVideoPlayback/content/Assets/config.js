var config = {
	settings:
	{
        autoPlay: false,
        autoDownload: false,
        fullscreenAbility: true,
        playBtn: "Assets/play.png",
        downloadBtn: "Assets/download.png",
        fullscreenBtn: "Assets/fullscreen.png"
	},
	vids:
	[
        {
			path: "Assets/youtube.3gp",
			url: "https://www.youtube.com/watch?v=QowwaefoCec",
			//availability: false, // AREL will communicate with flash and the flash side will check if the video file is available for offline playback or not.
			
			// your video dimension.
			vidWidth: 360,
			vidHeight: 640,
			
			// your trackable Image dimension
			sensorWidth: 400,
			sensorHeight: 283
		}
	]
}