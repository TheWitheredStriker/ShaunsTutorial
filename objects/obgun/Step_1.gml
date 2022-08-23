/// @description This code executes before all other steps

x           := obPlayer.x;
y           := obPlayer.y + 10;
image_angle := point_direction(x, y, mouse_x, mouse_y); 

firingdelay--; // - 1
recoil      := max(0, recoil - 1);

if (mouse_check_button(mb_left) and (firingdelay < 0)) then
begin

	recoil      := 4;
	firingdelay := 5;
	
	// All code within the "with" block is applied to the ID
	// created by instance_create_layer()
	
	with (instance_create_layer(x, y, "Bullets", obBullet))
	begin
		speed       := 25;
		direction   := other.image_angle + random_range(-3, 3); // "other" refers to the gun (i.e. the object this script is added to) 
		image_angle := direction; // Sets the angle of the bullets when they are drawn
	end
	
end

x -= lengthdir_x(recoil, image_angle);
y -= lengthdir_y(recoil, image_angle);

if ((image_angle > 90) and (image_angle < 270)) then
	image_yscale = -1;

else
	image_yscale = 1;