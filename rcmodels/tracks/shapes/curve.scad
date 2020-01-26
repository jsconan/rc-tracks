
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
 * Defines some curved chunk shapes.
 *
 * @author jsconan
 * @version 0.1.0
 */

/**
 * Draws the shape of a curved border mount notch.
 * @param Number radius - The radius of the curve.
 * @param Number thickness - The thickness of the shape
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number edge - The width of each edge of the notch.
 * @param Number [direction] - The direction of the shape (1: right, -1: left)
 * @param Boolean [negative] - The shape will be used in a difference operation
 */
module curveBorderNotch(radius, thickness, slotDepth, edge, direction=1, negative=false) {
    start = negative ? 1 : 0;
    direction = direction >= 0 ? 1 : -1;
    length = edge * 2;
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
 * Draws the shape of a curved border mount notches for a full chunk.
 * @param Number radius - The radius of the curve.
 * @param Number length - The length of a chunk
 * @param Number angle - The angle of the curve
 * @param Number thickness - The thickness of the shape
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number edge - The width of each edge of the notch.
 * @param Boolean [negative] - The shape will be used in a difference operation
 */
module curveBorderNotches(radius, length, angle, thickness, slotDepth, edge, negative=false) {
    rotateZ(angle) {
        repeatMirror(axis=[0, 1, 0]) {
            rotateZ(-angle) {
                curveBorderNotch(
                    radius = radius,
                    thickness = thickness,
                    slotDepth = slotDepth,
                    edge = edge,
                    direction = 1,
                    negative = negative
                );
                rotateZ(getArcAngle(radius = radius, length = length / 2)) {
                    repeatMirror(axis=[0, 1, 0]) {
                        curveBorderNotch(
                            radius = radius,
                            thickness = thickness,
                            slotDepth = slotDepth,
                            edge = edge,
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
 * Draws the bottom border mount for a curved chunk
 * @param Number length - The length of a chunk
 * @param Number sheetThickness - The thickness of the sheet the border mount will hold.
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number borderEdge - The width of each edge of the border mount.
 * @param Number notchEdge - The width of a notch edge.
 * @param Number ratio - The ratio of the chunk
 */
module curveBorderBottom(length, sheetThickness, slotDepth, borderEdge, notchEdge, ratio = 1) {
    radius = length * ratio;
    defaultAngle = 90;
    angle = defaultAngle / ratio;
    ratioAngle = defaultAngle - angle;

    rotateZ(ratioAngle / 2) {
        difference() {
            union() {
                rotate_extrude(angle=angle, convexity=10) {
                    translateX(radius) {
                        borderBottomProfile(
                            slotWidth = sheetThickness + printTolerance,
                            slotDepth = slotDepth,
                            edge = borderEdge
                        );
                    }
                }
                translateZ(borderEdge) {
                    curveBorderNotches(
                        radius = radius,
                        length = length,
                        angle = angle / 2,
                        thickness = borderEdge + borderEdge,
                        slotDepth = slotDepth,
                        edge = notchEdge - printTolerance,
                        negative=false
                    );
                }
                rotateZ(-ratioAngle) {
                    translateY(radius) {
                        borderHook(
                            edge = notchEdge,
                            thickness = borderEdge - printResolution * 2,
                            negative = false
                        );
                    }
                }
            }
            translateX(radius) {
                rotateZ(-90) {
                    borderHook(
                        edge = notchEdge + printTolerance,
                        thickness = borderEdge - printResolution,
                        negative = true
                    );
                }
            }
        }
    }
}

/**
 * Draws the top border mount for a curved chunk
 * @param Number length - The length of a chunk
 * @param Number sheetThickness - The thickness of the sheet the border mount will hold.
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number borderEdge - The width of each edge of the border mount.
 * @param Number notchEdge - The width of a notch edge.
 * @param Number ratio - The ratio of the chunk
 */
module curveBorderTop(length, sheetThickness, slotDepth, borderEdge, notchEdge, ratio = 1) {
    radius = length * ratio;
    defaultAngle = 90;
    angle = defaultAngle / ratio;
    ratioAngle = defaultAngle - angle;

    rotateZ(ratioAngle / 2) {
        difference() {
            union() {
                rotate_extrude(angle=angle, convexity=10) {
                    translateX(radius) {
                        borderTopProfile(
                            slotWidth = sheetThickness + printTolerance,
                            slotDepth = slotDepth,
                            edge = borderEdge
                        );
                    }
                }

                translateZ(borderEdge) {
                    curveBorderNotches(
                        radius = radius,
                        length = length,
                        angle = angle / 2,
                        thickness = borderEdge + borderEdge,
                        slotDepth = slotDepth,
                        edge = notchEdge - printTolerance,
                        negative=false
                    );
                }
                rotateZ(-ratioAngle) {
                    translateY(radius) {
                        borderHook(
                            edge = notchEdge,
                            thickness = borderEdge - printResolution * 2,
                            negative = false
                        );
                    }
                }
            }
            translateX(radius) {
                rotateZ(-90) {
                    borderHook(
                        edge = notchEdge + printTolerance,
                        thickness = borderEdge - printResolution,
                        negative = true
                    );
                }
            }
        }
    }
}
