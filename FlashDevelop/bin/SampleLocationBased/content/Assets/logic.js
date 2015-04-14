arel.sceneReady(function()
{
	console.log("sceneReady");
	
	var sydney = new arel.LLA(-33.7969235,150.9224326, 0);
	var newyork = new arel.LLA(40.7033127, -73.979681, 0);
	var tokyo = new arel.LLA(35.673343, 139.710388, 0);
	var munich = new arel.LLA(48.1549107,11.5418357, 0);

	createPOIGeometry("1", "Sydney", sydney, "Sydney city!", "Assets/sydney.jpg");
	createPOIGeometry("2", "New York", newyork, "New York city!", "Assets/newyork.jpg");
	createPOIGeometry("3", "Tokyo", tokyo, "Tokyo city!", "Assets/tokyo.jpg");
	createPOIGeometry("4", "Munich", munich, "Munich city!", "Assets/munich.jpg");
	
	arel.Scene.setLLAObjectRenderingLimits(80, 2500);
});

function createPOIGeometry(id, title, location, description, thumb)
{
	var newPOI = new arel.Object.POI();
	newPOI.setID(id);
	newPOI.setTitle(title);
	newPOI.setLocation(location);
	newPOI.setThumbnail(thumb);
	newPOI.setIcon("");
	newPOI.setVisibility(true,false,true);
    
    var popup = new arel.Popup(
                               {
									buttons:{},
									description:description
                               });
    
    newPOI.setPopup(popup);
    
	arel.Scene.addObject(newPOI);
}

function closeCam()
{
	arel.Media.openWebsite("flash://CLOSE_AR");
}