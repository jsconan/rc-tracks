
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
 * Work in progress.
 *
 * @author jsconan
 * @version 0.1.0
 */

// Import the project's setup.
include <../util/setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // test the bottom border profile
    *borderBottomProfile(
        slotWidth = getSlotWidth(),
        slotDepth = borderSlotDepth,
        edge = borderBottomEdge
    );
    // test the top border profile
    *borderTopProfile(
        slotWidth = getSlotWidth(),
        slotDepth = borderSlotDepth,
        edge = borderTopEdge
    );
    // test the border tooth profile
    *borderToothProfile(
        slotDepth = borderSlotDepth,
        edge = borderBottomEdge,
        direction = -1,
        negative = true
    );
    *borderToothProfile(
        slotDepth = borderSlotDepth,
        edge = borderBottomEdge,
        direction = 1,
        negative = true
    );
    // test the border teeth profile
    *borderTeethProfile(
        length = chunkLength / 2,
        slotDepth = borderSlotDepth,
        edge = borderBottomEdge,
        negative = true
    );
    // test the border tooth extrusion
    borderTooth(
        thickness = getSlotWidth(),
        slotDepth = borderSlotDepth,
        edge = borderBottomEdge,
        direction = -1,
        negative = true,
        center = true
    );
    // test the border teeth extrusion
    *borderTeeth(
        length = chunkLength,
        thickness = getSlotWidth(),
        slotDepth = borderSlotDepth,
        edge = borderBottomEdge,
        negative = true,
        center = true
    );
    // test the border teeth extrusion for a complete chunk
    *borderTeethComplete(
        length = chunkLength,
        thickness = getSlotWidth(),
        slotDepth = borderSlotDepth,
        edge = borderBottomEdge,
        negative = true,
        center = true
    );
    // test the bottom border mount shape for a straight chunk
    *straightBorderBottom(
        length = chunkLength,
        sheetThickness = getSlotWidth(),
        slotDepth = borderSlotDepth,
        borderEdge = borderBottomEdge,
        toothEdge = borderToothEdge
    );
    // test the top border mount shape for a straight chunk
    *straightBorderTop(
        length = chunkLength,
        sheetThickness = getSlotWidth(),
        slotDepth = borderSlotDepth,
        borderEdge = borderTopEdge,
        toothEdge = borderToothEdge
    );
    // test the border sheet shape for a straight chunk
    *borderSheet(
        length = chunkLength / 2,
        height = borderHeight,
        thickness = borderThickness,
        slotDepth = borderSlotDepth,
        toothEdge = borderToothEdge
    );
    // test the complete border sheet shape for a straight chunk
    *borderSheetComplete(
        length = chunkLength,
        height = borderHeight,
        thickness = borderThickness,
        slotDepth = borderSlotDepth,
        toothEdge = borderToothEdge
    );
}
