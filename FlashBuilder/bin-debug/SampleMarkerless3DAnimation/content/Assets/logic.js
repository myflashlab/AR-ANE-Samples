var isFlying = true;
var fly;

arel.sceneReady(function()
{
	//arel.Debug.activate();
	//arel.Debug.deactivateArelLogStream();
	//arel.Debug.log("----------------- Let's get started -----------------");
	
	//enable advanced rendering
/*	arel.Scene.autoEnableAdvancedRenderingFeatures(function callback(success) {
		if(!success) {
			alert("Advanced rendering features disabled. This device does not support the advanced rendering features of the metaio SDK.");
		} 
	});
*/
	
	//adjust effects
	//arel.Scene.setDepthOfFieldParameters(0.1, 0.6, 0.2);
	
	//slightly reduce amount of motion blur
	//arel.Scene.setMotionBlurIntensity(0.8);
	
	// set the fly object
	fly = arel.Object.Model3D.create("fly", "Assets/fly.mfbx", "Assets/fly.jpg");
	fly.setVisibility(true);
	fly.setCoordinateSystemID(1);
	fly.setScale(new arel.Vector3D(1, 1, 1));
	var flyRotation = new arel.Rotation();
	flyRotation.setFromEulerAngleDegrees(new arel.Vector3D(90, 0, 0));
	fly.setRotation(flyRotation);
	arel.Scene.addObject(fly);
	
	fly.startAnimation("Take 001", true);
	arel.Events.setListener(fly, function(obj, type, params){handleFlyEvents(obj, type, params);});
});

function handleFlyEvents(obj, type, param)
{
	//check if there is tracking information available
	if (type && type === arel.Events.Object.ONTOUCHENDED)
	{
		if (isFlying)
		{
			obj.pauseAnimation();
			isFlying = false;
		}
		else
		{
			obj.startAnimation("Take 001", true);
			isFlying = true;
		}
		
	}
}

function closeCam()
{
	arel.Media.openWebsite("flash://CLOSE_AR");
}