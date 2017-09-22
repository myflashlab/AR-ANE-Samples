// Before we get started with using the Wikitude JS classes, let me mention that
// you can simply read more about the Wikitude's JavaScript API by visitng their
// documentation reference: https://www.wikitude.com/external/doc/documentation/latest/Reference/JavaScript%20API/
//
// This is just a simple example to display a video. To learn more about the
// JavaScript API, and see more augmented reality samples, please visit the
// Wikitude's Github samples: https://github.com/Wikitude/wikitude-sdk-samples

var World = {
	loaded: false,

	init: function initFn() {
		this.createOverlays();
		this.setupCloseBtn();
	},

	createOverlays: function createOverlaysFn() {
		// We have logged in to the [Wikitude Studio Manager](https://targetmanager.wikitude.com/projects)
		// and created a new tracker file (assets/myflashlabs.wtc). Now let's
		// initalize it and provide it to the `AR.ImageTracker`.
		this.targetCollectionResource = new AR.TargetCollectionResource('assets/myflashlabs.wtc', {});

		// An `AR.ImageTracker` needs to be created by using the already initialized
		// `AR.TargetCollectionResource`, in order to start the recognition engine.
		// When the tracker loads all of its target images, the callback,
		// `this.worldLoaded`, will be fired.
		this.tracker = new AR.ImageTracker(this.targetCollectionResource, {
			onTargetsLoaded: this.worldLoaded
		});

		// Now let's create the augmentation. We use an image resource to pass it to
		// `AR.ImageDrawable`, which is a visual component that can be connected to
		// `AR.ImageTrackable` or `AR.GeoObject`. The `AR.ImageDrawable` is
		// initialized by the image, its size, and optional parameters.
		var playImg = new AR.ImageResource('assets/circle-black_play.png');
		var playBtn = new AR.ImageDrawable(playImg, .3, {
			enabled: false, // The button is disabled initially.
			zOrder: 2,
			translate: { y: 0 },
			onClick: function() {
				video.play(1); // Play the video once.
			}
		});

		// Let's initialize the `AR.VideoDrawable` as well.
		// In order to have an overlay video (augmented reality video), you should
		// use H.264 encoded videos with baseline profile in a mp4 container.
		// Read more here: https://www.wikitude.com/external/doc/documentation/latest/android/workingwithvideos.html#supported-video-codecs
		//
		// NOTE: As with all resources the video can be loaded locally from the
		// SD Card (like this example) or remotely from any server.
		var video = new AR.VideoDrawable('assets/myflashlabs.mp4', .4, {
			zOrder: 1,
			translate: { y: playBtn.translate.y },
			isPlaying: false,
			isFinished: false,
			onLoaded: function() {
				playBtn.enabled = true; // Enable the button when the video is loaded.
			},
			onPlaybackStarted: function() {
				playBtn.enabled = false; // Disable the button again when video is started playing.
				video.isFinished = false;
				video.isPlaying = true;
			},
			onFinishedPlaying: function() {
				playBtn.enabled = true; // Enable button when video is finished.
				video.isFinished = true;
				video.isPlaying = false;
			},
			onClick: function() {
				if (video.isFinished) return;

				if (video.isPlaying) {
					video.pause();
					video.isPlaying = false;
				} else {
					video.resume();
					video.isPlaying = true;
				}
			}
		});

		// Finally, let's combine everything together by defining the
		// `AR.ImageTrackable`. We simply provide it with our tracker and drawables
		// that should be displayed on the recognized target images.
		// In our example we use '*' as the target name, because we like the same
		// video to be displayed when user scans any of our targets. If we liked to
		// do different things according to the scanned target, we had to initialize
		// `AR.ImageTrackable` two times, and each time provide it the necessary
		// target name.
		//
		// NOTE: We used '*' as the target name. That means that the
		// `AR.ImageTrackable` will respond to any target that is defined in the
		// target collection. You can use wildcards to specify more complex name
		// matchings. E.g. 'target_?' to reference 'target_1' through 'target_9' or
		// 'target*' for any targets names that start with 'target'.
		var pageOne = new AR.ImageTrackable(this.tracker, '*', {
			drawables: {
				cam: [video, playBtn]
			},
			onEnterFieldOfVision: function() {
				if (video.isPlaying) {
					video.resume();
				}
			},
			onExitFieldOfVision: function() {
				if (video.isPlaying) {
					video.pause();
				}
			}
		});
	},

	setupCloseBtn: function setupCloseBtnFn() {
		// Add the close button's listener
		document.getElementById('close').addEventListener('click', function(e) {
			AR.platform.sendJSONObject( { action: 'close_ar' });
		});
	},

	worldLoaded: function worldLoadedFn() {
		// Now the tracker is loaded, let's remove the `loading` element from HTML,
		// and show user the targets to scan instead.
		document.getElementById('loading').classList.add('hidden');
		document.getElementById('targets').classList.remove('hidden');

		// Let's also remove the 'targets' element after 5 sec to clear the view.
		setTimeout(function() {
			document.getElementById('targets').classList.add('hidden');
		}, 5000);
	}
};

World.init();
