//$vpr=[30,0,0];

module toScreen(x, y){
    x = tan(($vpf/2)-$vpr[0]) * $vpd;
    echo(x=x);
    y = tan($vpf/2) * $vpd;
    translate([0,-x+10,0]) translate($vpt) rotate($vpr) children();
}

toScreen(0,0) text(str("$vpr=",$vpr[2]),size=10);
echo($vpt=$vpt,$vpr=$vpr,$vpd=$vpd,$vpf=$vpf);