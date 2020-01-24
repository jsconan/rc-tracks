
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
 * Draws the extrusion of border mount teeth for a complete chunk.
 * @param Number length - The length of the chunk
 * @param Number thickness - The thickness of the extrusion
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number edge - The width of each edge of the border mount.
 * @param Boolean [negative] - The shape will be used in a difference operation
 * @param Boolean [center] - The shape is centered vertically
 */
module borderTeethChunk(length, thickness, slotDepth, edge, negative=false, center=false) {
    negativeExtrude(height=thickness, center=center) {
        borderTeethChunkProfile(
            length = length / 2,
            slotDepth = slotDepth,
            edge = edge,
            negative = negative
        );
    }
}

/**
 * Draws the bottom border mount for a straight chunk
 * @param Number length - The length of the chunk
 * @param Number sheetThickness - The thickness of the sheet the border mount will hold.
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number edge - The width of each edge of the border mount.
 */
module straightBorderBottom(length, sheetThickness, slotDepth, edge) {
    rotate([90, 0, 90]) {
        negativeExtrude(height=length, center=true) {
            borderBottomProfile(
                slotWidth = sheetThickness,
                slotDepth = slotDepth,
                edge = edge
            );
        }
    }
    translateZ(edge) {
        rotateX(90) {
            borderTeethChunk(
                length = length,
                thickness = sheetThickness * 2,
                slotDepth = slotDepth,
                edge = edge,
                negative = false,
                center = true
            );
        }
    }
}
