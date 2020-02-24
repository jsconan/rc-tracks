/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2020 Jean-Sebastien CONAN
 *
 * This file is part of jsconan/things.
 *
 * jsconan/things is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * jsconan/things is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with jsconan/things. If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * A race track system for 1/24 to 1/32 scale RC cars.
 *
 * Defines the curved track parts.
 *
 * @author jsconan
 */

/**
 * Draws the notch shape of a curved barrier holder.
 * @param Number radius - The radius of the curve.
 * @param Number thickness - The thickness of the shape.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 */
module curvedBarrierNotch(radius, thickness, base, distance = 0) {
    width = getBarrierNotchWidth(base, distance);
    strip = getBarrierStripHeight(base);
    indent = getBarrierStripIndent(base);
    height = strip - indent;
    angle = getArcAngle(radius = radius, length = width);
    chord = getChordLength(radius = radius, angle = getArcAngle(radius = radius, length = indent));
    startAngle = angle / 2;

    difference() {
        translateZ(-base) {
            pipeSegment(
                r = radius + thickness / 2,
                h = height + base,
                w = thickness,
                a = angle,
                a1 = -startAngle
            );
        }
        repeatMirror(axis = [0, 1, 0]) {
            rotateZ(startAngle) {
                translateX(radius) {
                    rotate([90, 0, 270]) {
                        negativeExtrude(height = thickness + 1, center = true) {
                            polygon(path([
                                ["P", 0, -base],
                                ["V", base],
                                ["L", chord, height],
                                ["V", base],
                                ["H", -base],
                                ["V", -height - base * 2]
                            ]), convexity = 10);
                        }
                    }
                }
            }
        }
    }
}

/**
 * Place a curved element with respect to the length and the ratio.
 * @param Number length - The length of a track element.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The angle of the curve.
 * @param Number z - An option Z-axis translation
 */
module placeCurvedElement(length, radius, angle, z = 0) {
    remainingAngle = curveAngle - angle;
    offset = (length - radius) * cos(45) * [1, 1, 0] + [0, 0, z];

    translate(offset) {
        rotateZ(remainingAngle / 2) {
            children();
        }
    }
}

/**
 * Adds the links to a curved element.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The angle of the curve.
 * @param Number linkHeight - The height of the link.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number right - Is the curve oriented to the right?
 */
module curvedLinks(radius, angle, linkHeight, base, right = false) {
    remainingAngle = curveAngle - angle;
    maleLinkDirection = right ? 180 : 0;
    maleLinkPosition = right ? 270 : -remainingAngle;
    femaleLinkDirection = right ? 90 : -90;
    femaleLinkPosition = right ? 90 - remainingAngle : 0;

    rotateZ(maleLinkPosition) {
        translateY(radius) {
            rotateZ(maleLinkDirection) {
                barrierLink(
                    height = linkHeight - printResolution,
                    base = base
                );
            }
        }
    }
    difference() {
        children();
        rotateZ(femaleLinkPosition) {
            translate([radius, 0, -1]) {
                rotateZ(femaleLinkDirection) {
                    barrierLink(
                        height = linkHeight + printResolution + 1,
                        base = base,
                        distance = printTolerance
                    );
                }
            }
        }
    }
}

/**
 * Extrudes the profile on the expected circle path.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The extrusion angle.
 */
module extrudeCurvedProfile(radius, angle) {
    rotate_extrude(angle=angle, convexity=10) {
        translateX(radius) {
            children();
        }
    }
}

/**
 * Draws the main shape of a curved barrier holder.
 * @param Number length - The length of the element.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number ratio - The ratio to apply on the radius
 * @param Number right - Is the curve oriented to the right?
 */
module curvedBarrierMain(length, thickness, base, ratio = 1, right = false) {
    radius = getCurveRadius(length, ratio);
    angle = getCurveAngle(ratio);
    linkHeight = getBarrierHolderHeight(base) - base;

    placeCurvedElement(length=length, radius=radius, angle=angle) {
        curvedLinks(radius=radius, angle=angle, linkHeight=linkHeight, base=base, right=right) {
            extrudeCurvedProfile(radius=radius, angle=angle) {
                barrierHolderProfile(
                    base = base,
                    thickness = thickness
                );
            }
        }
    }
}

/**
 * Draws the shape of a curved unibody barrier.
 * @param Number length - The length of the element.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the barrier body for a barrier holder.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number ratio - The ratio to apply on the radius
 * @param Number right - Is the curve oriented to the right?
 */
module curvedBarrierUnibody(length, height, thickness, base, ratio = 1, right = false) {
    radius = getCurveRadius(length, ratio);
    angle = getCurveAngle(ratio);
    linkHeight = height - getBarrierHolderHeight(base) - base;

    placeCurvedElement(length=length, radius=radius, angle=angle) {
        curvedLinks(radius=radius, angle=angle, linkHeight=linkHeight, base=base, right=right) {
            extrudeCurvedProfile(radius=radius, angle=angle) {
                barrierUnibodyProfile(
                    height = height,
                    base = base,
                    thickness = thickness + printTolerance
                );
            }
        }
    }
}

/**
 * Draws the barrier holder for a curved track element.
 * @param Number length - The length of the element.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number ratio - The ratio to apply on the radius
 * @param Number right - Is the curve oriented to the right?
 */
module curvedBarrierHolder(length, thickness, base, ratio = 1, right = false) {
    radius = getCurveRadius(length, ratio);
    angle = getCurveAngle(ratio);
    linkHeight = getBarrierHolderHeight(base) - base;
    thickness = thickness + printTolerance;

    difference() {
        curvedBarrierMain(
            length = length,
            thickness = thickness,
            base = base,
            ratio = ratio,
            right = right
        );
        placeCurvedElement(length=length, radius=radius, angle=angle, z=minThickness) {
            difference() {
                pipeSegment(
                    r = radius + thickness / 2,
                    h = linkHeight * 2,
                    w = thickness,
                    a = angle
                );

                arcAngle = getArcAngle(radius = radius, length = length / 2);
                angles = [
                    [0, 0, 0],
                    [0, 0, arcAngle],
                    [0, 0, angle - arcAngle],
                    [0, 0, angle]
                ];

                repeatRotateMap(angles) {
                    curvedBarrierNotch(
                        radius = radius,
                        thickness = thickness * 2,
                        base = base,
                        distance = printTolerance / 2
                    );
                }
            }
        }
    }
}
