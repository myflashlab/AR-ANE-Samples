/*!
 * SampleMarkerlessVideoPlayback - V1.0
 * 
 * HOW TO USE THE JS LOGIC FROM FLASH:
 * // "flash://READY_AR" when flash receives this string, it means that AREL is ready to start
 * getConfig(); // flash calls this method to get the config.js and change it if needed (it can add availability property to the vids array)
 * init($obj); // flash calls this method to start AREL and provides it the new modified config
 * 
 * // "flash://toDownloadVid={path:'Assets/target_1.3g2', url:'http://example.com/vids/target_1.3g2', id:0}" when flash receives a similar string it means that it should download the online video and put it where that is specified
 * downloadInProgress($vidId, $perc); // while downloading the video it MAY call this method to let JS know the download progress so that it can show it in HTML
 * downloadComplete($vidId); // when download is complete it MUST call this method to let JS know that download is complete, so that JS start tracking again
 * // NOTE: if flash likes to close AR when downloading, then there's no need to call the 2 above methods for downloading, it only needs to call init($obj) method when it again starts AR
 * 
 * // "flash://toFullscreen={path:'Assets/target_1.3g2', id:0}" when flash receives a similar string it means that it SHOULD close AR and show the video in fullscreen
 * init($obj); // after showing the video in fullscreen and returning to AREL, of course flash MUST listen to "flash://READY_AR" and then call this method and provide its modified config again to start AREL
 * 
 * // "flash://CLOSE_AR" when flash receives this string, it means that AREL called flash to close it (AREL itself cannot close itself, flash must close it)
 * toggleCamFreeze(); // flash MAY call this method to freeze and unfreeze the camera and tracking
 * //isCamFreeze; // use it to get whether the camera is freeze or not
 */

var targetVidId = 0;

var vid = null;
var playBtn = null;
var fullscreenBtn = null;
var downloadBtn = null;

var isCamFreeze = false;
var lastClick = 0;
var isVidPlaying = config.settings.autoPlay;

var lastCoordinateSystemID = 0;




arel.sceneReady(function()
{
	arel.Media.openWebsite("flash://READY_AR");
	//init();
});

function onReady()
{
	//set a listener to tracking to get information about when the image is tracked
	arel.Events.setListener(arel.Scene, function(type, param){trackingHandler(type, param);});
	
	arel.Scene.autoEnableAdvancedRenderingFeatures(function callback(success){}); //enable advanced rendering
	arel.Scene.setDepthOfFieldParameters(0.1, 0.6, 0.2); //adjust effects
	arel.Scene.setMotionBlurIntensity(0.8); //slightly reduce amount of motion blur
	
	// set play button
	playBtn = arel.Object.Model3D.createFromImage("playBtn", config.settings.playBtn);
	(config.settings.autoPlay) ? playBtn.setVisibility(false) : playBtn.setVisibility(true);
	playBtn.setScale(new arel.Vector3D(1, 1, 1));
	var playBtnPos = (config.settings.fullscreenAbility) ? new arel.Vector3D(-40, 0, 10) : new arel.Vector3D(0, 0, 10);
	playBtn.setTranslation(playBtnPos);
	playBtn.setPickingEnabled(false); 
	arel.Scene.addObject(playBtn);
	
	// set fullscreen button
	if(config.settings.fullscreenAbility)
	{
		fullscreenBtn = arel.Object.Model3D.createFromImage("fullscreenBtn", config.settings.fullscreenBtn);
		(config.settings.autoPlay) ? fullscreenBtn.setVisibility(false) : fullscreenBtn.setVisibility(true);
		fullscreenBtn.setScale(new arel.Vector3D(1, 1, 1));
		fullscreenBtn.setTranslation(new arel.Vector3D(40, 0, 11));
		arel.Events.setListener(fullscreenBtn, function(obj, type, params){handleFullscreenEvents(obj, type, params);});
		arel.Scene.addObject(fullscreenBtn);
	}
	
	// set download button
	if(!config.settings.autoDownload)
	{
		downloadBtn = arel.Object.Model3D.createFromImage("downloadBtn", config.settings.downloadBtn);
		downloadBtn.setVisibility(false);
		downloadBtn.setScale(new arel.Vector3D(1, 1, 1));
		downloadBtn.setTranslation(new arel.Vector3D(0, 0, 10));
		arel.Events.setListener(downloadBtn, function(obj, type, params){handleDownloadEvents(obj, type, params);});
		arel.Scene.addObject(downloadBtn);
	}
}




function trackingHandler(type, param)
{
	if(param[0] !== undefined) //check if param so that we can be sure that the event has been fired with ready data
	{
		if(type && type == arel.Events.Scene.ONTRACKING) // now if the scene event is ONTRACKING then params will be arel.TrackingValues
		{
			// now that we are sure params are arel.TrackingValues, let's check them out and act accordingly
			if (param[0].getState() == arel.Tracking.STATE_TRACKING) //if a pattern is tracking
			{
				// if the current pattern is the same pattern that was found last time, then just play the vid and return
				if (lastCoordinateSystemID == param[0].getCoordinateSystemID()) // for the very first time lastCoordinateSystemID is 0 it's not equal to param[0].getCoordinateSystemID() so we continue the function and create vid in vidCreate() for the first time
				{
					if (isVidPlaying && vid) vid.startMovieTexture();
					if (vid) return; // now just return!
				}
				
				
				/////////////////////////////////////////////////////////////////// now if it's a new CoordinateSystemID (new tracking pattern)
				var targetVidId = param[0].getCoordinateSystemID() - 1;
				playBtn.setCoordinateSystemID(param[0].getCoordinateSystemID());
				if (fullscreenBtn) fullscreenBtn.setCoordinateSystemID(param[0].getCoordinateSystemID());
				
				// first destroy the last one and create a new one
				if (vid) vid = vidDestroy(vid); // we should check if vid os ok, because for the very first time it's just null, so there's nothing to destroy
				
				if (!config.vids[targetVidId].availability) // now check if the video that we should initialize exists or not!
				{
					if (targetVidId == 0 && !config.settings.autoPlay)
					{
						if (playBtn.getCoordinateSystemID() == 1)
						{
							playBtn.setVisibility(false);
							if (fullscreenBtn) fullscreenBtn.setVisibility(false);
						}
					}
					
					if (config.settings.autoDownload) // if autoDownload is true in the config object, then just return to flash so that it can download the video
					{
						callFlashToDownloadVid(targetVidId);
					}
					else // if autoDownload is false, then downloadBtn is available so make it visible
					{
						downloadBtn.setCoordinateSystemID(param[0].getCoordinateSystemID());
						downloadBtn.setVisibility(true);
					}
					return; // now just return!
				}
				
				
				/////////////////////////////////////////////////////////////////// now if it's both, a new CoordinateSystemID (new tracking pattern) and the target video exists, do the following
				vid = vidCreate(vid, targetVidId);
				lastCoordinateSystemID = param[0].getCoordinateSystemID();
				
				if (downloadBtn) downloadBtn.setVisibility(false);
				if (!isVidPlaying)
				{
					playBtn.setVisibility(true);
					if (fullscreenBtn) fullscreenBtn.setVisibility(true);
				}
			}
			else if(param[0].getState() == arel.Tracking.STATE_NOTTRACKING) //if the pattern is lost tracking
			{
				var vidExists = arel.Scene.objectExists( "vid" + param[0].getCoordinateSystemID() );
				if (vidExists) arel.Scene.getObject("vid" + param[0].getCoordinateSystemID()).pauseMovieTexture();
			}
		}
	}
}

function vidDestroy($vid)
{
	$vid.pauseMovieTexture();
	arel.Events.removeListener($vid);
	arel.Scene.removeObject($vid);
	$vid = null;
	
	return $vid;
}

function vidCreate($vid, $trackedPatt)
{
	$vid = arel.Object.Model3D.createFromMovie("vid" + ($trackedPatt + 1), config.vids[$trackedPatt].path); // create Model3D of the tracked pattern
	
	$vid.setVisibility(true);
	$vid.setCoordinateSystemID($trackedPatt + 1);
	
	var w = 100;
	var h = (config.vids[$trackedPatt].vidWidth * 100) / config.vids[$trackedPatt].vidHeight;	// (vidW * 100) / vidH
	var multi_w_Ax = config.vids[$trackedPatt].sensorWidth / w;									// imgW / w
	var multi_h_Ax = config.vids[$trackedPatt].sensorHeight / h;								// imgH / h
	$vid.setScale(new arel.Vector3D(multi_w_Ax, multi_h_Ax, 1));
	
	arel.Events.setListener($vid, function(obj, type, params){handleVidEvents(obj, type, params);});
	arel.Scene.addObject($vid);
	if(isVidPlaying) $vid.startMovieTexture();
	
	return $vid;
}

function handleVidEvents(obj, type, param)
{
	if (type && type === arel.Events.Object.ONTOUCHENDED)
	{
		if (isVidPlaying)
		{
			obj.pauseMovieTexture();
			isVidPlaying = false;
			playBtn.setVisibility(true);
			if (fullscreenBtn) fullscreenBtn.setVisibility(true);
		}
		else
		{
			obj.startMovieTexture();
			isVidPlaying = true;
			playBtn.setVisibility(false);
			if (fullscreenBtn) fullscreenBtn.setVisibility(false);
		}
	}
	else if (type && type === arel.Events.Object.ONMOVIEENDED)
	{
		if (config.settings.autoPlay)
		{
			obj.startMovieTexture();
		}
		else
		{
			obj.startMovieTexture();
			setTimeout(function()
			{
				obj.pauseMovieTexture();
				isVidPlaying = false;
				playBtn.setVisibility(true);
				if (fullscreenBtn) fullscreenBtn.setVisibility(true);
			}, 240);
		}
	}
}

function handleFullscreenEvents(obj, type, param)
{
	var jsonObj = {};
	jsonObj.path = config.vids[targetVidId].path;
	jsonObj.id = targetVidId;
	
	if (type && type === arel.Events.Object.ONTOUCHENDED)
	{
		arel.Media.openWebsite("flash://toFullscreen=" + JSON.stringify(jsonObj));
	}
}

function handleDownloadEvents(obj, type, param)
{
	if (type && type === arel.Events.Object.ONTOUCHENDED)
	{
		callFlashToDownloadVid(targetVidId);
	}
}
function callFlashToDownloadVid($targetId)
{
	arel.Events.removeListener(arel.Scene); // remove the listener from scene so that it cannot detect any new sensor as we are downloading a video
	var url = config.vids[$targetId].url;
	var path = config.vids[$targetId].path;
	
	var jsonObj = {};
	jsonObj.path = path;
	jsonObj.url = url;
	jsonObj.id = $targetId;
	
	arel.Media.openWebsite("flash://toDownloadVid=" + JSON.stringify(jsonObj));
}



function closeCam()
{
	arel.Media.openWebsite("flash://CLOSE_AR");
}




////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Flash may call the following methods
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function getConfig()
{
	arel.Media.openWebsite("flash://config=" + JSON.stringify(config));
}

function init($obj)
{
	if($obj != undefined) // if Flash provided us with a new config object
	{
		if (typeof($obj) == "string") $obj = JSON.parse($obj);
		config = $obj; // now save the new configuration
		
		// now reset any variable that is depending on the config settings
		isVidPlaying = config.settings.autoPlay;
	}
	
	onReady();
}

function myjavascriptfunc()
{
	
}

function toggleCamFreeze()
{
	if (!isCamFreeze)
	{
		arel.Scene.setFreezeTracking(true);
		arel.Scene.stopCamera();
		isCamFreeze = true;
	}
	else
	{
		arel.Scene.startCamera(0);
		arel.Scene.setFreezeTracking(false);
		isCamFreeze = false;
	}
}

function downloadComplete($vidId)
{
	arel.Events.setListener(arel.Scene, function(type, param){trackingHandler(type, param);}); // add scene listener so that it can again start detecting new sensors
	
	$vidId = parseInt($vidId);
	
	config.vids[$vidId].availability = true; // now flash told us that the specified video is ready, we can change its availability to true inside of the config object
	
	document.getElementById("download-box").innerHTML = "";
	document.getElementById("download-box").className = "download-box-invisible";
	
	// we only and only create video here, because the user may have stayed on the sensor and didn't move the camera... in this situation, the trackingHandler() won't be called again, because the camera didn't move and is still on the already detected sensor! So that's why after the downloading is complete we should create the video here too so that if the user didn't move the camera, yet he can watch the downloaded video immediatly
	if (vid) vid = vidDestroy(vid);
	vid = vidCreate(vid, $vidId);
	playBtn.setCoordinateSystemID($vidId + 1); // reset the play button's CoordinateSystemID
	if (fullscreenBtn) fullscreenBtn.setCoordinateSystemID($vidId + 1); // reset the fullscreen button's CoordinateSystemID
	lastCoordinateSystemID = $vidId + 1;
	if (downloadBtn) downloadBtn.setVisibility(false);
	if (!isVidPlaying)
	{
		playBtn.setVisibility(true);
		if (fullscreenBtn) fullscreenBtn.setVisibility(true);
	}
}

function downloadInProgress($vidId, $perc)
{
	$vidId = parseInt($vidId);
	
	document.getElementById("download-box").className = "download-box-visible";
	document.getElementById("download-box").innerHTML = $perc + "%";
}
