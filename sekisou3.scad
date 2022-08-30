$fs = 0.5;
$fa = 5;
fname = "SEKISOU3.DXF";
colour = [0.95, 0.95, 1, 0.4];
// Extract values from DXF
base01 = dxf_cross(file=fname, layer="base01");
base02 = dxf_cross(file=fname, layer="base02");
base03 = dxf_cross(file=fname, layer="base03");
base04 = dxf_cross(file=fname, layer="base04");
base05 = dxf_cross(file=fname, layer="base05");
base06 = dxf_cross(file=fname, layer="base06");
base11 = dxf_cross(file=fname, layer="base11");
base12 = dxf_cross(file=fname, layer="base12");
base13 = dxf_cross(file=fname, layer="base13");
base14 = dxf_cross(file=fname, layer="base14");

L01     = dxf_dim(file=fname, layer="dims", name="L01");
L02     = dxf_dim(file=fname, layer="dims", name="L02");
L03     = dxf_dim(file=fname, layer="dims", name="L03");
L04     = dxf_dim(file=fname, layer="dims", name="L04");
L05     = dxf_dim(file=fname, layer="dims", name="L05");
L06     = dxf_dim(file=fname, layer="dims", name="L06");
L11     = dxf_dim(file=fname, layer="dims", name="L11");
L12     = dxf_dim(file=fname, layer="dims", name="L12");
L13     = dxf_dim(file=fname, layer="dims", name="L13");
L14     = dxf_dim(file=fname, layer="dims", name="L14");

echo("L01",L01);
echo("L02",L02);
echo("L03",L03);
echo("L04",L04);
echo("L05",L05);
echo("L06",L06);
echo("L11",L11);
echo("L12",L12);
echo("L13",L13);
echo("L14",L14);

move01	= [0, 0, 0];
move02  = [0, 0, L01];
move03  = [0, 0, L01+L02];
move04  = [0, 0, 0];
move05	= [0, 0, 0];
move06  = [0, 0, 0];
move11  = [0, L11/2, 0];
move12  = [0, 0, 0];
move13  = [0, 0, 0];
move14  = [0, 0, 0];
union(){
    intersection(){
        union() {
            place_panel("panel01", base01, [0, 0, 0], move01,L01);
            place_panel("panel02", base02, [0, 0, 0], move02,L02);
            place_panel("panel03", base03, [0, 0, 0], move03,L03);
        }
        place_panel("panel11", base11, [1, 0, 0], move11,L11);
        place_panel("panel12", base12, [0, 1, 0], move12,L12);
    }
    difference() {
        translate ([0,0,L04])sphere(r = L13);
        translate ([-10,-10,-20])cube(size = [20, 20, 20], center = false);
    }
    translate ([0,0,L04])rotate([0, 90, 0])cylinder(h=L06, r=L05, center=false);
}

//
module place_panel(side, origin, rotation, location, thickness ) {
	translate (location)
		rotate (90, rotation)
			linear_extrude(file=fname, layer=side, height=thickness, convexity=10, origin=origin);
}
