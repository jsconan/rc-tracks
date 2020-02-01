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
 * Computes the outer length of a barrier link.
 * @param Number base - The base value used to design the barrier link.
 * @param Number [distance] - An additional distance added to the outline.
 * @returns Number
 */
function getBarrierLinkLength(base, distance = 0) = base * 1.5 + distance;

/**
 * Computes the outer width of a barrier link.
 * @param Number base - The base value used to design the barrier link.
 * @param Number [distance] - An additional distance added to the outline.
 * @returns Number
 */
function getBarrierLinkWidth(base, distance = 0) = (base + distance) * 2;

/**
 * Computes the outer width of a barrier holder notch.
 * @param Number base - The base value used to design the barrier link.
 * @param Number indent - The indent of the barrier body strip.
 * @param Number [distance] - An additional distance added to the outline.
 * @returns Number
 */
function getBarrierNotchWidth(base, indent, distance = 0) = (getBarrierLinkWidth(base, distance) + indent + minWidth) * 2;

/**
 * Computes the inner width of a barrier holder notch.
 * @param Number base - The base value used to design the barrier link.
 * @param Number indent - The indent of the barrier body strip.
 * @param Number [distance] - An additional distance added to the outline.
 * @returns Number
 */
function getBarrierNotchDistance(base, indent, distance = 0) = (getBarrierLinkWidth(base, distance) + minWidth) * 2;

/**
 * Computes the outer width of a barrier holder.
 * @param Number base - The base value used to design the barrier link.
 * @param Number [distance] - An additional distance added to the outline.
 * @returns Number
 */
function getBarrierHolderWidth(base, distance = 0) = getBarrierLinkWidth(base, distance) + minWidth * 4;

/**
 * Computes the outer height of a barrier holder.
 * @param Number strip - The height of the barrier body part that will be inserted in the holder.
 * @returns Number
 */
function getBarrierHolderHeight(strip) = strip + minThickness + printResolution;

/**
 * Computes the inner height of the barrier body.
 * @param Number height - The height of the barrier body.
 * @param Number strip - The height of the barrier body part that will be inserted in the holder.
 * @returns Number
 */
function getBarrierInnerHeight(height, strip, indent) = height - strip * 2;

/**
 * Gets the length of a curved ctrack elementhunk (the length of the arc of the curve).
 * @param Number length - The length of the track element.
 * @returns Number
 */
function getCurveLength(length) = getArcLength(radius = length, angle = 90);

/**
 * Gets the difference between the length of a curved track element chunk and a straight track element
 * @param Number length - The length of the track element.
 * @returns Number
 */
function getCurveRemainingLength(length) = getCurveLength(length) - length;

/**
 * Computes the minimal length of a track element.
 * @param Number base - The base value used to design the barrier link.
 * @param Number indent - The indent of the barrier body strip.
 * @param Number [distance] - An additional distance added to the outline.
 * @returns Number
 */
function getMinLength(base, indent, distance = 0) = getBarrierNotchWidth(base, indent, distance) * 4;


// The minimal thickness of a part
minThickness = layers(2);

// The minimal width of a part
minWidth = shells(2);

// The minimal size for a track element
minTrackSectionSize = getBarrierNotchWidth(barrierLinkBase, barrierStripIndent, printTolerance) * 4;
minBarrierHeight = barrierStripHeight * 3;

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
