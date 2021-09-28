
$vpr = [$vpr[0], 0, $t * 360]; // animated rotate around Z
echo($vpt=$vpt,$vpr=$vpr,$vpd=$vpd,$vpf=$vpf);
x = tan($vpf/2) * $vpd;
echo(x=x);
translate([0,-x+10,0]) translate($vpt) rotate($vpr) text(str("$vpr=",$vpr[2]),size=10);