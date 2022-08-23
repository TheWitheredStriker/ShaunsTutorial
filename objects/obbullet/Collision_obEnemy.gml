/// @description Enemy collision

// Specifically target the exact enemy the bullet struck

with (other) begin
	hp--; // Subtract 1
	flash := 3;
end

// Destroy bullet

instance_destroy();




