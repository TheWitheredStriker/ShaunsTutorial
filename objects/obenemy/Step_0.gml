/// @description This script runs every frame.

#region Movement code

vsp += grv;

#endregion END Movement code

#region Collision handling

// Horizontal collision

if (place_meeting(x + hsp, y, obWall)) then 
begin

	// "sign" returns 1 for positive numbers, -1 for negative numbers and 0 for neither (the number 0).

	while (not place_meeting(x + sign(hsp), y, obWall))
		x += sign(hsp);
		
	hsp := 0;
	
end 

x += hsp;

// Vertical collision

if (place_meeting(x, y + vsp, obWall)) then 
begin

	while (not place_meeting(x, y + sign(vsp), obWall))
		y += sign(vsp);
		
	vsp := 0;
	
end

y += vsp;

#endregion END Collision handling

#region Player animation 

if (not place_meeting(x, y + 1, obWall)) then
begin

	sprite_index := spEnemyJump;
	image_speed  := 0;
	
	if (sign(vsp) > 0) then
		image_index := 1;
	
	else
		image_index := 0;
	
end

else begin

	image_speed := 1;
	
	if (hsp == 0) then
		sprite_index := spEnemy;
		
	else
		sprite_index := spEnemyRun;
	
end

#endregion END Player animation

#region Misc.

// Flip sprite when moving left.
// We check if the player is moving, and if so, in what direction.
// sign(hsp) returns 1 if the player is moving right and -1 if they move left.

if (hsp <> 0) then
	image_xscale := sign(hsp);

#endregion END Misc.