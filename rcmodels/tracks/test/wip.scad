
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
        slotDepth = getSlotDepth(),
        edge = getBottomEdge()
    );
    // test the top border profile
    *borderTopProfile(
        slotWidth = getSlotWidth(),
        slotDepth = getSlotDepth(),
        edge = getTopEdge()
    );
    // test the border notch profile
    *borderNotchProfile(
        slotDepth = getSlotDepth(),
        edge = getNotchEdge(),
        direction = -1,
        negative = true
    );
    // test the border notches profile
    *borderNotchesProfile(
        length = getChunkLength() / 2,
        slotDepth = getSlotDepth(),
        edge = getNotchEdge(),
        negative = true
    );
    // test the border hook shape
    *borderHook(
        edge = getNotchEdge(),
        thickness = getNotchEdge(),
        negative=false
    );
    // test the border notch shape
    *borderNotch(
        thickness = getSlotWidth(),
        slotDepth = getSlotDepth(),
        edge = getNotchEdge(),
        direction = -1,
        negative = true,
        center = true
    );
    // test the border notches shape
    *borderNotches(
        length = getChunkLength(),
        thickness = getSlotWidth(),
        slotDepth = getSlotDepth(),
        edge = getNotchEdge(),
        negative = true,
        center = true
    );
    // test the border notches shape for a full chunk
    *borderNotchesFull(
        length = getChunkLength(),
        thickness = getSlotWidth(),
        slotDepth = getSlotDepth(),
        edge = getNotchEdge(),
        negative = true,
        center = true
    );
    // test the bottom border mount shape for a straight chunk
    *straightBorderBottom(
        length = getChunkLength(),
        sheetThickness = getSlotWidth(),
        slotDepth = getSlotDepth(),
        borderEdge = getBottomEdge(),
        notchEdge = getNotchEdge()
    );
    // test the top border mount shape for a straight chunk
    *straightBorderTop(
        length = getChunkLength(),
        sheetThickness = getSlotWidth(),
        slotDepth = getSlotDepth(),
        borderEdge = getTopEdge(),
        notchEdge = getNotchEdge()
    );
    // test the curved border notch
    *curveBorderNotch(
        radius = getChunkLength(),
        thickness = getSlotWidth(),
        slotDepth = getSlotDepth(),
        edge = getNotchEdge(),
        direction = 1,
        negative = true
    );
    // test the bottom border mount shape for a curved chunk
    *curveBorderBottom(
        length = getChunkLength(),
        sheetThickness = getSlotWidth(),
        slotDepth = getSlotDepth(),
        borderEdge = getBottomEdge(),
        notchEdge = getNotchEdge(),
        ratio = 1
    );
    // test the top border mount shape for a curved chunk
    *curveBorderTop(
        length = getChunkLength(),
        sheetThickness = getSlotWidth(),
        slotDepth = getSlotDepth(),
        borderEdge = getTopEdge(),
        notchEdge = getNotchEdge(),
        ratio = 1
    );
    // test the border sheet shape for a straight chunk
    *borderSheet(
        length = getCurveRemainingLength(getChunkLength()),
        height = getSheetHeight(),
        thickness = getSheetThickness(),
        slotDepth = getSlotDepth(),
        notchEdge = getNotchEdge()
    );
    // test the full border sheet shape for a straight chunk
    borderSheetFull(
        length = getChunkLength(),
        height = getSheetHeight(),
        thickness = getSheetThickness(),
        slotDepth = getSlotDepth(),
        notchEdge = getNotchEdge()
    );
}
