/// @description This script runs every frame.

#region Cheatsheat

/**
   CONVERSION CHEATSHEAT
   
   begin ... end           <-> { ... }
   and, or, xor, not, mod  <-> &&, ||, ^^, !, %
   :=, <>                  <-> =, !=
   
   SHORTHANDS CHEATSHEAT
   
   +=, -=, *=, /=  <-> a = a + ..., a = a - ..., etc
   a++, a--        <-> a = a + 1, a = a - 1
   ++a, --a        <-> same, but returns the variable WITHOUT the extra 1
   
   E.g. 2++ = 3, ++2 = 2
   
   a ? b: c        <-> if (a) then b; else c
   
   E.g. (x > 5) ? doThis: doThat <-> if (x > 5) then doThis; else doThat
   
*/

#endregion END Cheatsheat

#region Variable declaration

// We read the keyboard input. If the user holds the left or right arrow key, we return true, or 1. (False is 0)
// My keyboard uses AZERTY (ZQSD); if you use QWERTY (WASD), replace the Q in keyLeft with an A.

var 
	keyLeft   := keyboard_check(vk_left) or keyboard_check(ord("Q")), 
	keyRight  := keyboard_check(vk_right) or keyboard_check(ord("D")),
	keyJump   := keyboard_check_pressed(vk_space), // keyboard_check_pressed() checks for a single press only, not for holddown
	
	// Return the value 0 if both left and right are pressed simultaneously (1 - 1).
	// This prevents the player from moving if they do that.
	
	move      := keyRight - keyLeft,
	
	hsp       := move * walksp;

#endregion END Variable declaration

#region Movement code

vsp += grv; // We add the gravity value to our vertical speed.

// If we're off the ground and space was hit, then make our character jump.
// This function "place_meeting" specifically checks for collision.
// Specifically, it checks if your character is one value above their "y" and if there's a wall object below it.
// For example, the function "place_meeting(x - 5, y, obWall)" would check for collision 5 pixels to the left of our character.
// NOTE: The wall object refers to all ground and wall tiles.

if (place_meeting(x, y + 1, obWall) and keyJump) then
	vsp := -7;

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

	sprite_index := spPlayerJump;
	image_speed  := 0;
	
	if (sign(vsp) > 0) then
		image_index := 1;
	
	else
		image_index := 0;
	
end

else begin

	image_speed := 1;
	
	if (hsp == 0) then
		sprite_index := spPlayer;
		
	else
		sprite_index := spPlayerRun;
	
end

#endregion END Player animation

#region Misc.

// Flip sprite when moving left.
// We check if the player is moving, and if so, in what direction.
// sign(hsp) returns 1 if the player is moving right and -1 if they move left.

if (hsp <> 0) then
	image_xscale := sign(hsp);

#endregion END Misc.