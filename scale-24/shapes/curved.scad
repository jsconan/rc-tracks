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
 * Defines the curved track parts.
 *
 * @author jsconan
 */

/**
 * Gets the approximated length of the shape of a curved barrier.
 * @param Number length - The length of the element.
 * @param Number width - The width of the element.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number ratio - The ratio to apply on the radius
 * @returns Number
 */
function getCurvedBarrierLength(length, width, base, ratio) =
    let(
        angle = getCurveAngle(ratio),
        radius = getCurveRadius(length, ratio),
        rotationAngle = getCurveRotationAngle(angle),
        projectedWidth = width * cos(rotationAngle) / 2,
        projectedLink = getBarrierLinkLength(base) * cos(CURVE_ANGLE + rotationAngle)
    )
    getChordLength(angle, radius) +
    width / 2 + projectedWidth + max(0, projectedLink - projectedWidth)
;

/**
 * Gets the approximated width of the shape of a curved barrier.
 * @param Number length - The length of the element.
 * @param Number width - The width of the element.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number ratio - The ratio to apply on the radius
 * @returns Number
 */
function getCurvedBarrierWidth(length, width, base, ratio) =
    let(
        angle = getCurveAngle(ratio),
        radius = getCurveRadius(length, ratio),
        rotationAngle = getCurveRotationAngle(angle),
        projectedWidth = width * sin(rotationAngle) / 2,
        projectedLink = getBarrierLinkLength(base) * sin(CURVE_ANGLE + rotationAngle)
    )
    getChordHeight(angle, radius) +
    width / 2 + projectedWidth + max(0, projectedLink - projectedWidth)
;

/**
 * Draws the notch shape of a curved barrier holder.
 * @param Number radius - The radius of the curve.
 * @param Number thickness - The thickness of the shape.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 */
module curvedBarrierNotch(radius, thickness, base, distance = 0) {
    width = getBarrierNotchWidth(base, distance);
    indent = getBarrierStripIndent(base);
    height = getBarrierStripHeight(base) - indent;
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
                        linear_extrude(height=thickness + 1, center=true, convexity=10) {
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
 * Places a curved element.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The angle of the curve.
 * @param Number z - An option Z-axis translation.
 */
module placeCurvedElement(radius, angle, z=0) {
    translate([0, getChordHeight(angle, radius) / 2 - radius, z]) {
        rotateZ(getCurveRotationAngle(angle)) {
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
    remainingAngle = CURVE_ANGLE - angle;
    maleLinkDirection = right ? 180 : 0;
    maleLinkPosition = right ? 270 : -remainingAngle;
    femaleLinkDirection = right ? 90 : -90;
    femaleLinkPosition = right ? 90 - remainingAngle : 0;

    rotateZ(maleLinkPosition) {
        translateY(radius) {
            rotateZ(maleLinkDirection) {
                barrierLink(
                    height = linkHeight - layerHeight,
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
                        height = linkHeight + layerHeight + 1,
                        base = base,
                        distance = printTolerance
                    );
                }
            }
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
    linkHeight = getBarrierHolderLinkHeight(base);

    placeCurvedElement(radius=radius, angle=angle) {
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
    linkHeight = getBarrierUnibodyLinkHeight(height, base);

    placeCurvedElement(radius=radius, angle=angle) {
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
    linkHeight = getBarrierHolderLinkHeight(base);
    thickness = thickness + printTolerance;

    difference() {
        curvedBarrierMain(
            length = length,
            thickness = thickness,
            base = base,
            ratio = ratio,
            right = right
        );
        placeCurvedElement(radius=radius, angle=angle, z=minThickness) {
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
