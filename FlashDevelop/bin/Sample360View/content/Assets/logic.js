arel.sceneReady(function()
{
	var obj360 = arel.Object.Model3D.create("obj360", "Assets/sphere.md2", "Assets/texture.jpg");
	obj360.setTranslation(new arel.Vector3D(0,0,-1500));
	obj360.setVisibility(true);
	obj360.setScale(new arel.Vector3D(40000, 40000, 40000));
	var obj360Rotation = new arel.Rotation();
	obj360Rotation.setFromEulerAngleDegrees(new arel.Vector3D(90, 0, 0));
	obj360.setRotation(obj360Rotation);
	obj360.setRenderOrderPosition(-1000);
	arel.Scene.addObject(obj360);
});

function closeCam()
{
	arel.Media.openWebsite("flash://CLOSE_AR");
}