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
 * Defines some curved track parts.
 *
 * @author jsconan
 * @version 0.1.0
 */

/**
 * Draws the shape of a curved barrier holder notch.
 * @param Number radius - The radius of the curve.
 * @param Number thickness - The thickness of the shape
 * @param Number slotDepth - The depth of the slot that will hold the barrier body.
 * @param Number base - The base value used to design the barrier notches.
 * @param Number [direction] - The direction of the shape (1: right, -1: left)
 * @param Boolean [negative] - The shape will be used in a difference operation
 */
module curveBarrierNotch(radius, thickness, slotDepth, base, direction=1, negative=false) {
    start = negative ? 1 : 0;
    direction = direction >= 0 ? 1 : -1;
    length = base * 2;
    angle = getArcAngle(radius = radius, length = length);
    chord = getChordLength(radius = radius, angle = angle / 2);

    difference() {
        translateZ(-start) {
            pipeSegment(
                r = radius + thickness / 2,
                h = slotDepth + start,
                w = thickness,
                a1 = -direction * getArcAngle(radius = radius, length = start),
                a2 = direction * angle
            );
        }

        rotateZ(direction * angle) {
            translateX(radius) {
                rotate([90, 0, 270]) {
                    negativeExtrude(height = thickness + 1, center = true) {
                        polygon([
                            [0, 0],
                            [direction * chord, slotDepth],
                            [direction * chord, slotDepth + 1],
                            [direction * -1, slotDepth + 1],
                            [direction * -1, 0],
                        ]);
                    }
                }
            }
        }
    }
}

/**
 * Draws the shape of a curved barrier holder notches for a full chunk.
 * @param Number radius - The radius of the curve.
 * @param Number length - The length of a chunk
 * @param Number angle - The angle of the curve
 * @param Number thickness - The thickness of the shape
 * @param Number slotDepth - The depth of the slot that will hold the barrier body.
 * @param Number base - The base value used to design the barrier notches.
 * @param Boolean [negative] - The shape will be used in a difference operation
 */
module curveBarrierNotches(radius, length, angle, thickness, slotDepth, base, negative=false) {
    rotateZ(angle) {
        repeatMirror(axis=[0, 1, 0]) {
            rotateZ(-angle) {
                curveBarrierNotch(
                    radius = radius,
                    thickness = thickness,
                    slotDepth = slotDepth,
                    base = base,
                    direction = 1,
                    negative = negative
                );
                rotateZ(getArcAngle(radius = radius, length = length / 2)) {
                    repeatMirror(axis=[0, 1, 0]) {
                        curveBarrierNotch(
                            radius = radius,
                            thickness = thickness,
                            slotDepth = slotDepth,
                            base = base,
                            direction = -1,
                            negative = negative
                        );
                    }
                }
            }
        }
    }
}

/**
 * Draws the barrier holder for a curved chunk
 * @param Number length - The length of a chunk
 * @param Number bodyThickness - The thickness of the barrier body.
 * @param Number slotDepth - The depth of the slot that will hold the barrier body.
 * @param Number barrierBase - The base value used to design the barrier holder.
 * @param Number notchBase - The width of a notch base.
 * @param Number ratio - The ratio of the chunk
 */
module curveBarrierHolder(length, bodyThickness, slotDepth, barrierBase, notchBase, ratio = 1) {
    radius = length * ratio;
    defaultAngle = 90;
    angle = defaultAngle / ratio;
    ratioAngle = defaultAngle - angle;

    rotateZ(ratioAngle / 2) {
        difference() {
            union() {
                rotate_extrude(angle=angle, convexity=10) {
                    translateX(radius) {
                        barrierHolderProfile(
                            slotWidth = bodyThickness + printTolerance,
                            slotDepth = slotDepth,
                            base = barrierBase
                        );
                    }
                }
                translateZ(barrierBase) {
                    curveBarrierNotches(
                        radius = radius,
                        length = length,
                        angle = angle / 2,
                        thickness = barrierBase + barrierBase,
                        slotDepth = slotDepth,
                        base = notchBase - printTolerance,
                        negative=false
                    );
                }
                rotateZ(-ratioAngle) {
                    translateY(radius) {
                        barrierHook(
                            base = notchBase,
                            thickness = barrierBase - printResolution * 2,
                            negative = false
                        );
                    }
                }
            }
            translateX(radius) {
                rotateZ(-90) {
                    barrierHook(
                        base = notchBase + printTolerance,
                        thickness = barrierBase - printResolution,
                        negative = true
                    );
                }
            }
        }
    }
}
