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
function adjustToNozzle(width) = roundBy(width, nozzleWidth);

/**
 * Gets the thickness of the barrier body, adjusted to better fit the printer.
 * @returns Number
 */
function getBarrierThickness() = adjustToLayer(barrierThickness);

/**
 * Gets the base value used to design the barrier holder, adjusted to better fit the printer.
 * @returns Number
 */
function getBarrierHolderBase() = adjustToNozzle(barrierHolderBase);

/**
 * Gets the base value used to design the barrier notches, adjusted to better fit the printer.
 * @returns Number
 */
function getBarrierNotchBase() = adjustToNozzle(barrierNotchBase);

/**
 * Gets the width of the slot that will hold the barrier body.
 * @returns Number
 */
function getSlotWidth() = getBarrierThickness();

/**
 * Gets the depth of the slot that will hold the barrier body.
 * @returns Number
 */
function getBarrierHolderDepth() = adjustToLayer(barrierHolderDepth);

/**
 * Gets the nominal size of a track chunk.
 * @returns Number
 */
function getChunkSize() = chunkSize;

/**
 * Gets the length of a curved chunk (the length of the arc of the curve).
 * @param Number chunkSize - The length of a straight chunk
 * @returns Number
 */
function getCurveLength(chunkSize) = getArcLength(radius = chunkSize, angle = 90);

/**
 * Gets the difference between the length of a curved chunk and a regular straight chunk
 * @param Number chunkSize - The length of a straight chunk
 * @returns Number
 */
function getCurveRemainingLength(chunkSize) = getCurveLength(chunkSize) - chunkSize;

/**
 * Gets the height of the barrier body
 * @returns Number
 */
function getBarrierBodyHeight() = barrierHeight - barrierHolderBase * 2;

/**
 * Gets the height of the assembled barrier
 * @returns Number
 */
function getBarrierHeight() = barrierHeight;

/**
 * Gets the minimal length for a simple body body (a body that should fit between 2 barrier notches)
 * @returns Number
 */
function getMinBodyLength() = 5 * getBarrierNotchBase();

/**
 * Gets the minimal length for a straight chunk
 * @returns Number
 */
function getMinStraightLength() = 2 * getMinBodyLength();

/**
 * Gets the minimal arc length for a curved chunk
 * @returns Number
 */
function getMinCurveLength() = 3 * getMinBodyLength();
