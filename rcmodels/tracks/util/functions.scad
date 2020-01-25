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
 * Defines some functions.
 *
 * @author jsconan
 * @version 0.1.0
 */

/**
 * Ajust a height with respect to the target layer height
 * @param Number height
 * @returns Number
 */
function adjustToLayer(height) = roundBy(height, printResolution);

/**
 * Ajust a width with respect to the target nozzle size
 * @param Number width
 * @returns Number
 */
function adjustToNozzle(width) = roundBy(width, nozzle);

/**
 * Gets the width of the slot that will hold the border sheet.
 * @returns Number
 */
function getSlotWidth() = borderThickness + printTolerance;

/**
 * Gets the length of a curved chunk (the length of the arc of the curve).
 * @param Number chunkLength - The length of a straight chunk
 * @returns Number
 */
function getCurveLength(chunkLength) = getArcLength(radius = chunkLength, angle = 90);

/**
 * Gets the difference between the length of a curved chunk and a regular straight chunk
 * @param Number chunkLength - The length of a straight chunk
 * @returns Number
 */
function getCurveRemainingLength(chunkLength) = getCurveLength(chunkLength) - chunkLength;

/**
 * Gets the height of the border sheet, depending on the option heightWithFasteners
 * @returns Number
 */
function getSheetHeight() =
    let(
        correction = heightWithFasteners
       ?-(borderBottomEdge + borderTopEdge)
       :borderSlotDepth * 2
    )
    borderHeight + correction
;

/**
 * Gets the height of the assembled border, depending on the option heightWithFasteners
 * @returns Number
 */
function getBorderHeight() =
    let(
        correction = heightWithFasteners ? 0 : borderBottomEdge + borderTopEdge + borderSlotDepth * 2
    )
    borderHeight + correction
;

/**
 * Gets the minimal length for a simple sheet (a sheet that should fit between 2 border teeth)
 * @returns Number
 */
function getMinSheetLength() = 5 * borderToothEdge;

/**
 * Gets the minimal length for a complete straight sheet
 * @returns Number
 */
function getMinStraightLength() = 2 * getMinSheetLength();

/**
 * Gets the minimal length for a complete curved sheet
 * @returns Number
 */
function getMinCurveLength() = 3 * getMinSheetLength();
