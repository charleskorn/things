INNER_DIAMETER = 18;
WALL_THICKNESS = 2;
OUTER_DIAMETER = INNER_DIAMETER + 2 * WALL_THICKNESS;
HEIGHT = 20;

INNER_RADIUS = INNER_DIAMETER / 2;
OUTER_RADIUS = OUTER_DIAMETER / 2;

translate([0, 0, -WALL_THICKNESS]) {
    cylinder(h = WALL_THICKNESS, d = OUTER_DIAMETER, $fn = 200);
}

rounded_arc(90);
rotate([0, 0, 180]) rounded_arc(60);

module rounded_arc(angular_size) {
    intersection() {
        rotate_extrude(convexity = 10, height = HEIGHT, $fn = 200) {
            translate([INNER_RADIUS, 0, 0]) {
                square([WALL_THICKNESS, HEIGHT]);
            }
        }
        
        // Limit the extrude to the angle given.
        linear_extrude(height = HEIGHT) {
            distance = OUTER_RADIUS / (cos(0.5 * angular_size));
            
            polygon(points = [[0, 0],
                                [distance, 0],
                                [distance*cos(angular_size), distance*sin(angular_size)]]);
        }
    }
    
    rounded_arc_end(0);
    rounded_arc_end(angular_size);
}

module rounded_arc_end(angle) {
    rotate([0, 0, angle]) translate([INNER_RADIUS + WALL_THICKNESS / 2, 0, 0]) {
        cylinder(h = HEIGHT, d = WALL_THICKNESS, $fn = 20);  
    }
}