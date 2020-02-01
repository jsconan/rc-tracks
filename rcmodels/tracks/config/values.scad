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
 * Refines values and defines functions.
 *
 * @author jsconan
 * @version 0.1.0
 */

/**
 * Alligns a value with respect to the target layer height
 * @param Number value
 * @returns Number
 */
function layerAligned(value) = roundBy(value, printResolution);

/**
 * Alligns a value with respect to the target nozzle size
 * @param Number value
 * @returns Number
 */
function nozzleAligned(value) = roundBy(value, nozzleWidth);

/**
 * Gets the thickness of N layers
 * @param Number N
 * @returns Number
 */
function layers(N) = N * printResolution;

/**
 * Gets the width of N times the nozzle width
 * @param Number N
 * @returns Number
 */
function shells(N) = N * nozzleWidth;

/**
 * Gets the thickness of the barrier body, adjusted to better fit the printer.
 * @returns Number
 */
function getBarrierBodyThickness() = layerAligned(barrierBodyThickness);

/**
 * Gets the base value used to design the barrier holder, adjusted to better fit the printer.
 * @returns Number
 */
function getBarrierHolderBase() = nozzleAligned(barrierHolderBase);

/**
 * Gets the base value used to design the barrier notches, adjusted to better fit the printer.
 * @returns Number
 */
function getBarrierNotchBase() = nozzleAligned(barrierNotchBase);

/**
 * Gets the depth of the slot that will hold the barrier body.
 * @returns Number
 */
function getBarrierHolderDepth() = layerAligned(barrierHolderDepth);

/**
 * Gets the length of a curved chunk (the length of the arc of the curve).
 * @param Number trackSectionSize - The length of a straight chunk
 * @returns Number
 */
function getCurveLength(trackSectionSize) = getArcLength(radius = trackSectionSize, angle = 90);

/**
 * Gets the difference between the length of a curved chunk and a regular straight chunk
 * @param Number trackSectionSize - The length of a straight chunk
 * @returns Number
 */
function getCurveRemainingLength(trackSectionSize) = getCurveLength(trackSectionSize) - trackSectionSize;

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


// Validate the critical constraints
assert(
    trackSectionSize >= getMinStraightLength(),
    str(
        "The size for a straight chunk is too small! The minimum length is ",
        getMinStraightLength(),
        ". The current value is ",
        trackSectionSize
    )
);
assert(
    getArcLength(radius = trackSectionSize, angle = 90) >= getMinCurveLength(),
    str(
        "The length for a curved chunk is too small! The minimum arc length is ",
        getMinCurveLength(),
        ". The current value is ",
        getArcLength(radius = trackSectionSize, angle = 90)
    )
);
