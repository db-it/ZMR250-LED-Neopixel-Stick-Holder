// parameter
ledHolderLength = 0.5;

borderWidth = 1.5;
ledStripWidth = 51.5;
ledStripHeight = 10.5;
ledStripDepth = 4.0;

// connector hole
connHoleWidth = 5.4;
connHoleHeight = 10;
connHoleDepth = 1.6;

module basicPlate() {
    difference() {
        // led bar: 51.5 + Rand 2x 1.5 = 54.5
        totalPlateWidth = ledStripWidth + 2 * borderWidth;
        totalPlateHeight = ledStripHeight + 2 * borderWidth;
        cube([totalPlateWidth, ledStripDepth + borderWidth, totalPlateHeight]);
        translate([borderWidth, borderWidth, borderWidth]) {
            cube([ledStripWidth, ledStripDepth, ledStripHeight + borderWidth]);
        }
    }
}

module backPlate() {
    difference() {
        basicPlate();
        // connector space left
        translate([borderWidth, 0, borderWidth]) {
            connectorHole();
        }

        // connector space right
        translate([borderWidth + (ledStripWidth), connHoleDepth-0.1, borderWidth]) {
            rotate(180) connectorHole();
        }
    }
}


module connectorHole() {
    rotate(90, [-1,0,0]) {
        // 5.25/2 ~2.7
        translate([2.7, -7.3, 0]) cylinder(d = 5.4, h = 1.6, $fn=20);
    }
    cube([connHoleWidth, connHoleDepth, connHoleHeight-5.4/2]);
}

module holderPart() {
    holderHeight = 5.5;
    /* Distanz von Lochmittelpunkt zur geraden Kante
     * = translationY + cubeY
     */
    difference() {
        hull() {
            cylinder(h = holderHeight, d = 9.1, $fn=30);
            translate([-4.5, 2.5 + ledHolderLength, 0]) cube([9.1, 2, holderHeight]);
        }
        cylinder(h = 7.1, d = 5.5, $fn=45); // Loch
    }
}

module main() {
    backPlate(ledStripWidth, ledStripHeight, ledStripDepth, borderWidth);
    translate([11.45, (-4.5 - ledHolderLength), 0]) holderPart();
    translate([43.05, (-4.5 - ledHolderLength), 0]) holderPart();
}

main();
