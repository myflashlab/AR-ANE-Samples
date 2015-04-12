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
			path: "Assets/target_1.3g2",
			url: "http://myflashlab.com/showcase/AR/target_1.3g2",
			//availability: false, // AREL will communicate with flash and the flash side will check if the video file is available Form offline playback or not.
			
			// your converted video dimension. suggested tool for video conversion is FFMPEG
			vidWidth: 360,
			vidHeight: 640,
			
			// your trackable Image dimension
			sensorWidth: 400,
			sensorHeight: 283
		}
	]
}