
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
 * A 1/24 RC track system.
 *
 * Defines some straight chunk shapes.
 *
 * @author jsconan
 * @version 0.1.0
 */

/**
 * Draws the shape of a border mount hook.
 * @param Number edge - The width of each edge of the hook.
 * @param Number thickness - The thickness of the hook
 * @param Boolean [negative] - The shape will be used in a difference operation
 */
module borderHook(edge, thickness, negative=false) {
    start = negative ? 1 : 0;
    edge = adjustToNozzle(edge / 2) * 2;
    translateZ(-start) {
        box([edge * 2, edge, thickness + start]);
        translateX(-edge) {
            slot([edge, edge * 2, thickness + start]);
        }
    }
}

/**
 * Draws the shape of border mount notch.
 * @param Number thickness - The thickness of the shape
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number edge - The width of each edge of the notch.
 * @param Number [direction] - The direction of the shape (1: right, -1: left)
 * @param Boolean [negative] - The shape will be used in a difference operation
 * @param Boolean [center] - The shape is centered vertically
 */
module borderNotch(thickness, slotDepth, edge, direction=1, negative=false, center=false) {
    negativeExtrude(height=thickness, center=center) {
        borderNotchProfile(
            slotDepth = slotDepth,
            edge = edge,
            direction = direction,
            negative = negative
        );
    }
}

/**
 * Draws the shape of border mount notches.
 * @param Number length - The length of the chunk
 * @param Number thickness - The thickness of the shape
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number edge - The width of each edge of the notch.
 * @param Boolean [negative] - The shape will be used in a difference operation
 * @param Boolean [center] - The shape is centered vertically
 */
module borderNotches(length, thickness, slotDepth, edge, negative=false, center=false) {
    negativeExtrude(height=thickness, center=center) {
        borderNotchesProfile(
            length = length,
            slotDepth = slotDepth,
            edge = edge,
            negative = negative
        );
    }
}

/**
 * Draws the shape of border mount notches for a full chunk.
 * @param Number length - The length of the chunk
 * @param Number thickness - The thickness of the shape
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number edge - The width of each edge of the notch.
 * @param Boolean [negative] - The shape will be used in a difference operation
 * @param Boolean [center] - The shape is centered vertically
 */
module borderNotchesFull(length, thickness, slotDepth, edge, negative=false, center=false) {
    repeatMirror() {
        borderNotches(
            length = length / 2,
            thickness = thickness,
            slotDepth = slotDepth,
            edge = edge,
            negative = negative,
            center = center
        );
    }
}

/**
 * Draws the bottom border mount for a straight chunk
 * @param Number length - The length of the chunk
 * @param Number sheetThickness - The thickness of the sheet the border mount will hold.
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number borderEdge - The width of each edge of the border mount.
 * @param Number notchEdge - The width of a notch edge.
 */
module straightBorderBottom(length, sheetThickness, slotDepth, borderEdge, notchEdge) {
    difference() {
        union() {
            rotate([90, 0, 90]) {
                negativeExtrude(height=length, center=true) {
                    borderBottomProfile(
                        slotWidth = sheetThickness + printTolerance,
                        slotDepth = slotDepth,
                        edge = borderEdge
                    );
                }
            }
            translateZ(borderEdge) {
                rotateX(90) {
                    borderNotchesFull(
                        length = length,
                        thickness = sheetThickness + borderEdge,
                        slotDepth = slotDepth,
                        edge = notchEdge - printTolerance,
                        negative = false,
                        center = true
                    );
                }
            }
            translateX(-length / 2) {
                borderHook(
                    edge = notchEdge,
                    thickness = borderEdge - printResolution * 2,
                    negative = false
                );
            }
        }
        translateX(length / 2) {
            borderHook(
                edge = notchEdge + printTolerance,
                thickness = borderEdge - printResolution,
                negative = true
            );
        }
    }
}

/**
 * Draws the top border mount for a straight chunk
 * @param Number length - The length of the chunk
 * @param Number sheetThickness - The thickness of the sheet the border mount will hold.
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number borderEdge - The width of each edge of the border mount.
 * @param Number notchEdge - The width of a notch edge.
 */
module straightBorderTop(length, sheetThickness, slotDepth, borderEdge, notchEdge) {
    difference() {
        union() {
            rotate([90, 0, 90]) {
                negativeExtrude(height=length, center=true) {
                    borderTopProfile(
                        slotWidth = sheetThickness + printTolerance,
                        slotDepth = slotDepth,
                        edge = borderEdge
                    );
                }
            }
            translateZ(borderEdge) {
                rotateX(90) {
                    borderNotchesFull(
                        length = length,
                        thickness = sheetThickness + borderEdge,
                        slotDepth = slotDepth,
                        edge = notchEdge - printTolerance,
                        negative = false,
                        center = true
                    );
                }
            }
            translateX(-length / 2) {
                borderHook(
                    edge = notchEdge,
                    thickness = borderEdge - printResolution * 2,
                    negative = false
                );
            }
        }
        translateX(length / 2) {
            borderHook(
                edge = notchEdge + printTolerance,
                thickness = borderEdge - printResolution,
                negative = true
            );
        }
    }
}

/**
 * Draws the border sheet for a straight chunk
 * @param Number length - The length of the chunk
 * @param Number height - The height of the chunk
 * @param Number thickness - The thickness of the border sheet.
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number notchEdge - The width of a notch edge.
 */
module borderSheet(length, height, thickness, slotDepth, notchEdge) {
    difference() {
        box(size = [length, height, thickness], center = true);

        repeatMirror(axis=[0, 1, 0]) {
            translateY(-height / 2) {
                translateX(-length / 2) {
                    borderNotches(
                        length = length,
                        thickness = thickness + 1,
                        slotDepth = slotDepth,
                        edge = notchEdge + printTolerance,
                        negative = true,
                        center = true
                    );
                }
            }
        }
    }
}

/**
 * Draws the full border sheet for a straight chunk
 * @param Number length - The length of the chunk
 * @param Number height - The height of the chunk
 * @param Number thickness - The thickness of the border sheet.
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number notchEdge - The width of a notch edge.
 */
module borderSheetFull(length, height, thickness, slotDepth, notchEdge) {
    difference() {
        box(size = [length, height, thickness], center = true);

        repeatMirror(axis=[0, 1, 0]) {
            translateY(-height / 2) {
                borderNotchesFull(
                    length = length,
                    thickness = thickness + 1,
                    slotDepth = slotDepth,
                    edge = notchEdge + printTolerance,
                    negative = true,
                    center = true
                );
            }
        }
    }
}
