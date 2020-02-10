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
 * Draws the shape of a barrier holder notch for a curved track element.
 * @param Number radius - The radius of the curve.
 * @param Number thickness - The thickness of the shape.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 */
module barrierNotchCurved(radius, thickness, base, distance = 0) {
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
                            ]));
                        }
                    }
                }
            }
        }
    }
}

/**
 * Place a curved element with respect to the length and the ratio.
 * @param Number length - The length of the element.
 * @param Number ratio - The ratio to apply on the radius
 * @param Number z - An option Z-axis translation
 */
module placeCurvedElement(length, ratio = 1, z = 0) {
    radius = getCurveRadius(length, ratio);
    angle = getCurveAngle(ratio);
    ratioAngle = curveAngle - angle;
    offset = (length - radius) * cos(45) * [1, 1, 0] + [0, 0, z];

    translate(offset) {
        rotateZ(ratioAngle / 2) {
            children();
        }
    }
}

/**
 * Draws the main shape of a barrier holder for a curved track element.
 * @param Number length - The length of the element.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number ratio - The ratio to apply on the radius
 * @param Number right - Is the curve oriented to the right?
 */
module curvedBarrierMain(length, thickness, base, ratio = 1, right = false) {
    radius = getCurveRadius(length, ratio);
    angle = getCurveAngle(ratio);
    ratioAngle = curveAngle - angle;
    linkHeight = getBarrierHolderHeight(base) - base;

    outerLinkDirection = right ? 180 : 0;
    outerLinkPosition = right ? 270 : -ratioAngle;
    innerLinkDirection = right ? 90 : -90;
    innerLinkPosition = right ? 90 - ratioAngle : 0;

    placeCurvedElement(length, ratio) {
        rotateZ(outerLinkPosition) {
            translateY(radius) {
                rotateZ(outerLinkDirection) {
                    barrierLink(
                        height = linkHeight - printResolution,
                        base = base
                    );
                }
            }
        }
        difference() {
            rotate_extrude(angle=angle, convexity=10) {
                translateX(radius) {
                    barrierHolderProfile(
                        base = base,
                        thickness = thickness
                    );
                }
            }
            rotateZ(innerLinkPosition) {
                translate([radius, 0, -1]) {
                    rotateZ(innerLinkDirection) {
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
        placeCurvedElement(length, ratio, minThickness) {
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
                    barrierNotchCurved(
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
