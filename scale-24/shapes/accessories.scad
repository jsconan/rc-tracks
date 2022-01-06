/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2020-2022 Jean-Sebastien CONAN
 *
 * This file is part of jsconan/rc-tracks.
 *
 * jsconan/rc-tracks is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * jsconan/rc-tracks is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with jsconan/rc-tracks. If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * A race track system for 1/24 to 1/32 scale RC cars.
 *
 * Defines the shapes for the track accessories.
 *
 * @author jsconan
 */

/**
 * Gets the approximated length of the shape of a cable clip.
 * @param Number wall - The thickness of the cable clip lines.
 * @param Number base - The base unit value used to design the barrier holder.
 * @returns Number
 */
function getCableClipLength(wall, base) =
    getBarrierHolderWidth(base, wall)
;

/**
 * Gets the approximated width of the shape of a cable clip.
 * @param Number wall - The thickness of the cable clip lines.
 * @param Number base - The base unit value used to design the barrier holder.
 * @returns Number
 */
function getCableClipWidth(wall, base) =
    getBarrierHolderHeight(base, wall) +
    apothem(n=10, r=getCableClipLength(wall, base) / 2)
;

/**
 * Gets the approximated length of the shape of a bent accessory mast.
 * @param Number width - The width of the mast.
 * @param Number|Vector height - The height of the mast. The 2 sides can be defined separately using a vector.
 * @param Number wall - The thickness of the accessory clip lines.
 * @param Number base - The base unit value used to design the barrier holder.
 * @returns Number
 */
function getAccessoryBentMastLength(width, height, wall, base) =
    let(
        height = vector2D(height)
    )
    getBarrierHolderWidth(base, wall) / 2 +
    width + height[1]
;

/**
 * Gets the approximated width of the shape of a bent accessory mast.
 * @param Number width - The width of the mast.
 * @param Number|Vector height - The height of the mast. The 2 sides can be defined separately using a vector.
 * @param Number wall - The thickness of the accessory clip lines.
 * @param Number base - The base unit value used to design the barrier holder.
 * @returns Number
 */
function getAccessoryBentMastWidth(width, height, wall, base) =
    let(
        height = vector2D(height)
    )
    getBarrierHolderHeight(base, wall) +
    width * 1.5 + height[0]
;

/**
 * Gets the approximated length of the shape of an accessory mast.
 * @param Number height - The height of the mast.
 * @param Number wall - The thickness of the accessory clip lines.
 * @param Number base - The base unit value used to design the barrier holder.
 * @returns Number
 */
function getAccessoryStraightMastLength(height, wall, base) =
    getBarrierHolderHeight(base, wall) + height
;

/**
 * Gets the approximated width of the shape of an accessory mast.
 * @param Number wall - The thickness of the accessory clip lines.
 * @param Number base - The base unit value used to design the barrier holder.
 * @returns Number
 */
function getAccessoryStraightMastWidth(wall, base) =
    getBarrierHolderWidth(base, wall)
;

/**
 * Gets the approximated length of the shape of an accessory flag.
 * @param Number width - The width of the flag.
 * @param Number thickness - The thickness of the flag.
 * @param Number mast - The width of the mast.
 * @returns Number
 */
function getAccessoryFlagLength(width, thickness, mast) =
    width + mast / 2 + printResolution + thickness
;

/**
 * Gets the approximated length of the shape of an accessory flag.
 * @param Number height - The height of the flag.
 * @param Number wave - The height of the wave
 * @returns Number
 */
function getAccessoryFlagWidth(height, wave = 0) =
    height + wave * 2
;

/**
 * Draws the shape of a cable clip.
 * @param Number height - The thickness of the clip.
 * @param Number wall - The thickness of the cable clip lines.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 * @param Boolean [center] - The shape is centered vertically.
 */
module cableClip(height, wall, base, thickness, center = false) {
    clipWidth = getCableClipLength(wall, base);

    translateY((apothem(n=10, r=clipWidth) - getCableClipWidth(wall, base)) / 2) {
        linear_extrude(height=height, center=center, convexity=10) {
            clipProfile(
                wall = wall,
                base = base,
                thickness = thickness + printTolerance
            );
            repeat(intervalX = clipWidth - wall, center = true) {
                translateY(base / 2) {
                    rectangle([wall, base]);
                }
            }
            ringSegment(
                r = [1, 1] * (clipWidth / 2),
                w = wall,
                a = -180,
                $fn = 10
            );
        }
    }
}

/**
 * Draws the profile shape of an accessory mast.
 * @param Number width - The width of the mast.
 * @param Number [distance] - An additional distance added to the outline.
 */
module mastProfile(width, distance = 0) {
    radius = getMastRadius(width);

    polygon(
        points = outline(drawEllipse(r=radius, $fn=mastFacets), distance),
        convexity = 10
    );
}

/**
 * Draws the shape of an accessory mast.
 * @param Number width - The width of the mast.
 * @param Number height - The height of the mast.
 * @param Number [distance] - An additional distance added to the outline.
 * @param Boolean [center] - The shape is centered vertically.
 */
module mast(width, height, distance = 0, center = false) {
    linear_extrude(height=height, center=center, convexity=10) {
        rotateZ(getPolygonAngle(1, mastFacets) / 2) {
            mastProfile(
                width = width,
                distance = distance
            );
        }
    }
}

/**
 * Draws the shape of a bent accessory mast.
 * @param Number width - The width of the mast.
 * @param Number|Vector height - The height of the mast. The 2 sides can be defined separately using a vector.
 * @param Number [distance] - An additional distance added to the outline.
 */
module bentMast(width, height, distance = 0) {
    height = vector2D(height);

    mast(
        width = width,
        height = height[0],
        distance = distance,
        center = false
    );
    translate([0, -width, height[0] + width]) {
        rotateX(90) {
            mast(
                width = width,
                height = height[1],
                distance = distance,
                center = false
            );
        }
    }
    translate([0, -width, height[0]]) {
        rotate([90, 0, 90]) {
            rotate_extrude(angle=90, convexity=10) {
                translateX(width) {
                    rotateZ(getPolygonAngle(1, mastFacets) / 2) {
                        mastProfile(
                            width = width,
                            distance = distance
                        );
                    }
                }
            }
        }
    }
}

/**
 * Draws the shape of rings that will maintain an accessory onto a mast.
 * @param Number width - The width of the mast.
 * @param Number height - The height of the ring.
 * @param Number wall - The thickness of the accessory ring.
 * @param Number [interval] - The interval between 2 rings.
 * @param Number [count] - The number of rings.
 * @param Number [distance] - An additional distance added to the outline.
 * @param Boolean [center] - The shape is centered.
 */
module mastRings(width, height, wall, interval = 0, count = 1, distance = 0, center = false) {
    repeat(count=count, intervalX=interval, center=center) {
        rotateY(90) {
            difference() {
                mast(
                    width = width,
                    height = height,
                    distance = wall + distance,
                    center = center
                );
                mast(
                    width = width,
                    height = height * 2 + 1,
                    distance = distance,
                    center = true
                );
            }
        }
    }
}

/**
 * Draws the shape of an accessory mast with a clip.
 * @param Number width - The width of the mast.
 * @param Number height - The height of the mast.
 * @param Number wall - The thickness of the accessory clip lines.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 */
module accessoryStraightMast(width, height, wall, base, thickness) {
    clipHeight = getBarrierHolderHeight(base, wall);

    translateX((clipHeight - height) / 2) {
        rotateY(90) {
            mast(
                width = width,
                height = height,
                distance = 0,
                center = false
            );
        }
        rotateZ(90) {
            clip(
                wall = wall,
                height = width,
                base = base,
                thickness = thickness + printTolerance,
                center = true
            );
        }
    }
}

/**
 * Draws the shape of a bent accessory mast with a clip.
 * @param Number width - The width of the mast.
 * @param Number|Vector height - The height of the mast. The 2 sides can be defined separately using a vector.
 * @param Number wall - The thickness of the accessory clip lines.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 */
module accessoryBentMast(width, height, wall, base, thickness) {
    height = vector2D(height);
    clipWidth = getBarrierHolderWidth(base, wall);
    clipHeight = getBarrierHolderHeight(base, wall);
    bentMastLength = getAccessoryBentMastLength(width, height, wall, base);
    bentMastWidth = getAccessoryBentMastWidth(width, height, wall, base);

    translate([
        (clipWidth - bentMastLength) / 2,
        bentMastWidth / 2 - clipHeight,
        0
    ]) {
        rotate([0, 270, 90]) {
            bentMast(
                width = width,
                height = height,
                distance = 0
            );
        }
        clip(
            wall = wall,
            height = width,
            base = base,
            thickness = thickness + printTolerance,
            center = true
        );
    }
}

/**
 * Draws the shape of an accessory flag.
 * @param Number width - The width of the flag.
 * @param Number height - The height of the flag.
 * @param Number thickness - The thickness of the flag.
 * @param Number mast - The width of the mast.
 * @param Number wave - The height of the wave
 */
module accessoryFlag(width, height, thickness, mast, wave = 0) {
    distance = printResolution;
    ringHeight = height / 4;
    ringInterval = height - ringHeight;
    ringOffset = apothem(n=mastFacets, r=getMastRadius(mast)) + distance + thickness;
    type = wave ? "S" : "V";

    rotateZ(270) {
        translateY((mast - width) / 2 - printResolution) {
            translateZ(ringOffset) {
                mastRings(
                    width = mast,
                    height = ringHeight,
                    wall = thickness,
                    interval = ringInterval,
                    count = 2,
                    distance = distance,
                    center = true
                );
            }
            linear_extrude(height=thickness, convexity=10) {
                polygon(path([
                    ["P", height / 2, 0],
                    [type, width, width, wave, 0, 90],
                    ["H", -height],
                    [type, -width, width, wave, 0, 90]
                ]));
            }
        }
    }
}
