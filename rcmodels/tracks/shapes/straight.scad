
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
 * Draws the shape of border mount tooth.
 * @param Number thickness - The thickness of the shape
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number edge - The width of each edge of the border mount.
 * @param Number [direction] - The direction of the shape (1: right, -1: left)
 * @param Boolean [negative] - The shape will be used in a difference operation
 * @param Boolean [center] - The shape is centered vertically
 */
module borderTooth(thickness, slotDepth, edge, direction=1, negative=false, center=false) {
    negativeExtrude(height=thickness, center=center) {
        borderToothProfile(
            slotDepth = slotDepth,
            edge = edge,
            direction = direction,
            negative = negative
        );
    }
}

/**
 * Draws the shape of border mount teeth.
 * @param Number length - The length of the chunk
 * @param Number thickness - The thickness of the shape
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number edge - The width of each edge of the border mount.
 * @param Boolean [negative] - The shape will be used in a difference operation
 * @param Boolean [center] - The shape is centered vertically
 */
module borderTeeth(length, thickness, slotDepth, edge, negative=false, center=false) {
    negativeExtrude(height=thickness, center=center) {
        borderTeethProfile(
            length = length,
            slotDepth = slotDepth,
            edge = edge,
            negative = negative
        );
    }
}

/**
 * Draws the shape of border mount teeth for a full chunk.
 * @param Number length - The length of the chunk
 * @param Number thickness - The thickness of the shape
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number edge - The width of each edge of the border mount.
 * @param Boolean [negative] - The shape will be used in a difference operation
 * @param Boolean [center] - The shape is centered vertically
 */
module borderTeethFull(length, thickness, slotDepth, edge, negative=false, center=false) {
    repeatMirror() {
        borderTeeth(
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
 * @param Number toothEdge - The width of a tooth edge.
 */
module straightBorderBottom(length, sheetThickness, slotDepth, borderEdge, toothEdge) {
    rotate([90, 0, 90]) {
        negativeExtrude(height=length, center=true) {
            borderBottomProfile(
                slotWidth = sheetThickness,
                slotDepth = slotDepth,
                edge = borderEdge
            );
        }
    }
    translateZ(borderEdge) {
        rotateX(90) {
            borderTeethFull(
                length = length,
                thickness = sheetThickness,
                slotDepth = slotDepth,
                edge = toothEdge,
                negative = false,
                center = true
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
 * @param Number toothEdge - The width of a tooth edge.
 */
module straightBorderTop(length, sheetThickness, slotDepth, borderEdge, toothEdge) {
    rotate([90, 0, 90]) {
        negativeExtrude(height=length, center=true) {
            borderTopProfile(
                slotWidth = sheetThickness,
                slotDepth = slotDepth,
                edge = borderEdge
            );
        }
    }
    translateZ(borderEdge) {
        rotateX(90) {
            borderTeethFull(
                length = length,
                thickness = sheetThickness,
                slotDepth = slotDepth,
                edge = toothEdge,
                negative = false,
                center = true
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
 * @param Number toothEdge - The width of a tooth edge.
 */
module borderSheet(length, height, thickness, slotDepth, toothEdge) {
    difference() {
        box(size = [length, height, thickness], center = true);

        repeatMirror(axis=[0, 1, 0]) {
            translateY(-height / 2) {
                translateX(-length / 2) {
                    borderTeeth(
                        length = length,
                        thickness = thickness + 1,
                        slotDepth = slotDepth,
                        edge = toothEdge,
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
 * @param Number toothEdge - The width of a tooth edge.
 */
module borderSheetFull(length, height, thickness, slotDepth, toothEdge) {
    difference() {
        box(size = [length, height, thickness], center = true);

        repeatMirror(axis=[0, 1, 0]) {
            translateY(-height / 2) {
                borderTeethFull(
                    length = length,
                    thickness = thickness + 1,
                    slotDepth = slotDepth,
                    edge = toothEdge,
                    negative = true,
                    center = true
                );
            }
        }
    }
}
