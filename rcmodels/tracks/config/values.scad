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
 * @version 0.2.0
 */

/**
 * Alligns a value with respect to the target layer height.
 * @param Number value
 * @returns Number
 */
function layerAligned(value) = roundBy(value, printResolution);

/**
 * Alligns a value with respect to the target nozzle size.
 * @param Number value
 * @returns Number
 */
function nozzleAligned(value) = roundBy(value, nozzleWidth);

/**
 * Gets the thickness of N layers.
 * @param Number N
 * @returns Number
 */
function layers(N) = N * printResolution;

/**
 * Gets the width of N times the nozzle width.
 * @param Number N
 * @returns Number
 */
function shells(N) = N * nozzleWidth;

/**
 * Computes the height of the barrier body part that will be inserted in the holder.
 * @param Number base - The base unit value used to design the barrier holder.
 * @returns Number
 */
function getBarrierStripHeight(base) = base * barrierStripHeightRatio;

/**
 * Computes the indent of the barrier body strip.
 * @param Number base - The base unit value used to design the barrier holder.
 * @returns Number
 */
function getBarrierStripIndent(base) = base * barrierStripIndentRatio;

/**
 * Computes the outer length of a barrier link.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 * @returns Number
 */
function getBarrierLinkLength(base, distance = 0) = base * 1.5 + distance;

/**
 * Computes the outer width of a barrier link.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 * @returns Number
 */
function getBarrierLinkWidth(base, distance = 0) = (base + distance) * 2;

/**
 * Computes the outer width of a barrier holder notch.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 * @returns Number
 */
function getBarrierNotchWidth(base, distance = 0) = (getBarrierLinkWidth(base, distance) + getBarrierStripIndent(base) + minWidth) * 2;

/**
 * Computes the inner width of a barrier holder notch.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 * @returns Number
 */
function getBarrierNotchDistance(base, distance = 0) = (getBarrierLinkWidth(base, distance) + minWidth) * 2;

/**
 * Computes the outer width of a barrier holder.
 * @param Number base - The base unit value used to design the barrier holder.
 * @returns Number
 */
function getBarrierHolderWidth(base) = getBarrierLinkWidth(base, printTolerance) + minWidth * 4;

/**
 * Computes the outer height of a barrier holder.
 * @param Number base - The base unit value used to design the barrier holder.
 * @returns Number
 */
function getBarrierHolderHeight(base) = getBarrierStripHeight(base) + minThickness + printResolution;

/**
 * Computes the inner height of the barrier body, between the barrier holders.
 * @param Number height - The height of the barrier.
 * @returns Number
 */
function getBarrierBodyInnerHeight(height, base) = height - getBarrierStripHeight(base) * 2;

/**
 * Computes the outer height of the barrier body, taking care of the barrier holders.
 * @param Number height - The height of the barrier.
 * @returns Number
 */
function getBarrierBodyHeight(height) = height - (minThickness + printResolution) * 2;

/**
 * Gets the length of a curved ctrack elementhunk (the length of the arc of the curve).
 * @param Number length - The length of the track element.
 * @returns Number
 */
function getCurveLength(length) = getArcLength(radius = length, angle = 90);

/**
 * Gets the difference between the length of a curved track element chunk and a straight track element.
 * @param Number length - The length of the track element.
 * @returns Number
 */
function getCurveRemainingLength(length) = getCurveLength(length) - length;

/**
 * Computes the minimal length of a track element.
 * @param Number base - The base unit value used to design the barrier holder.
 * @returns Number
 */
function getMinLength(base) = getBarrierNotchWidth(base, printTolerance) * 4;


// The minimal thickness of a part
minThickness = layers(2);

// The minimal width of a part
minWidth = shells(2);

// The ratios applied to the base unit value used to design the barrier holder
barrierStripHeightRatio = 3;
barrierStripIndentRatio = 0.5;

// The ratio of the outer curve with respect to the track width
trackCurveRatio = (trackWidth + trackSectionSize) / trackSectionSize;

// The minimal size for a track element
minTrackSectionSize = getBarrierNotchWidth(barrierHolderBase, printTolerance) * 4;
minBarrierHeight = getBarrierStripHeight(barrierHolderBase) * 3;

// Validate the critical constraints
assert(
    trackSectionSize >= minTrackSectionSize,
    str(
        "The size for a track element is too small! The minimum length is ",
        minTrackSectionSize,
        ". The current value is ",
        trackSectionSize
    )
);
assert(
    barrierHeight >= minBarrierHeight,
    str(
        "The height for a track barrier is too small! The minimum height is ",
        minBarrierHeight,
        ". The current value is ",
        barrierHeight
    )
);
assert(
    trackWidth > trackSectionSize,
    "The width of the track must greater than the length of one element!"
);
assert(
    trackWidth % trackSectionSize == 0,
    "The width of the track must be a multiple of the length of one element!"
);
