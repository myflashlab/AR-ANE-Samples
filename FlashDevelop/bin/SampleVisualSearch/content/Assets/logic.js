var requestVS;
var fly;
var isFlying = true;

arel.sceneReady(function()
{
	arel.Debug.activate();
	arel.Debug.deactivateArelLogStream();
	arel.Debug.log("----------------- Let's get started -----------------");
	
	arel.Events.setListener(arel.Scene, function(type, param){sceneHandler(type, param);});
	
	requestVS = true;
	setInterval(function(){requestSearch();}, 1000);
});

function requestSearch()
{
	if (requestVS) 
	{
		arel.Scene.requestVisualSearch("dbtest1", true); // _databaseName, _returnFullTrackingConfig
		requestVS = false;
	}	
}

function sceneHandler(type, param)
{
	if(type && type == arel.Events.Scene.ONVISUALSEARCHRESULT)
	{
		if(param.length > 0)
		{
			for(var i = 0; i < param.length; i++)
			{
				arel.Debug.log("identifier = " + param[i].toString());
				arel.Debug.log("getMetadata = " + param[i].getMetadata());
				arel.Debug.log("----------------------");
			}
		
			/*
				when you get the metaData and identifier, you can decide what to do with your trackable!
				in this example we load our Logo, the Fly 3D model! you can do anything else like playing a video
				use our other demo projects and get going.
			*/
			
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
			
			arel.Scene.setTrackingConfiguration(param[0]);	
		}
		else 
		{
			requestVS = true;
		}
	}

	if(type && type == arel.Events.Scene.ONTRACKING && param[0] !== undefined)	
	{
		if  (param[0].getState() == arel.Tracking.STATE_TRACKING)
		{
			requestVS = false;
		}
		else if (param[0].getState() == arel.Tracking.STATE_NOTTRACKING)
		{
			requestVS = true;
		}
	}
};

function handleFlyEvents(obj, type, param)
{
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