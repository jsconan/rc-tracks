/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2022 Jean-Sebastien CONAN
 *
 * This file is part of jsconan/rc-tracks.
 *
 * jsconan/rc-tracks is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * jsconan/rc-tracks is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with jsconan/rc-tracks. If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * A race track system for 1/64 to 1/76 scale RC cars.
 *
 * Defines the helper functions for the barriers.
 *
 * @author jsconan
 */

/**
 * Computes the base unit value used to design the barrier shape.
 * @param Number width - The width of the barriers.
 * @param Number height - The height of the barriers.
 * @returns Number
 */
function getBarrierBaseUnit(width, height) = min(width, height) / 4;

/**
 * Computes the size of the offset for the barrier shape.
 * @param Number width - The width of the barriers.
 * @param Number height - The height of the barriers.
 * @returns Number
 */
function getBarrierOffset(width, height) = getBarrierBaseUnit(width, height) / 4;

/**
 * Computes the outer length of a barrier link.
 * @param Number width - The width of the barriers.
 * @param Number height - The height of the barriers.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 * @returns Number
 */
function getBarrierLinkLength(width, height, distance=0) = getBarrierBaseUnit(width, height) * 1.5 + distance;

/**
 * Computes the outer width of a barrier link.
 * @param Number width - The width of the barriers.
 * @param Number height - The height of the barriers.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 * @returns Number
 */
function getBarrierLinkWidth(width, height, distance=0) = (getBarrierBaseUnit(width, height) + distance) * 2;

/**
 * Computes the height of a barrier link.
 * @param Number width - The width of the barriers.
 * @param Number height - The height of the barriers.
 * @returns Number
 */
function getBarrierLinkHeight(width, height) = layerAligned(height - getBarrierBaseUnit(width, height));

/**
 * Computes the diameter of the barrier pegs.
 * @param Number width - The width of the barriers.
 * @param Number height - The height of the barriers.
 * @returns Number
 */
function getBarrierPegDiameter(width, height) = width - getBarrierBaseUnit(width, height) - shells(2);

/**
 * Computes the height of the barrier pegs that plugs into the barriers.
 * @param Number width - The width of the barriers.
 * @param Number height - The height of the barriers.
 * @returns Number
 */
function getBarrierPegInnerHeight(width, height) = layerAligned(getBarrierBaseUnit(width, height) * 1.5);

/**
 * Computes the overall height of the barrier pegs.
 * @param Number width - The width of the barriers.
 * @param Number height - The height of the barriers.
 * @param Number thickness - The thickness of the ground.
 * @returns Number
 */
function getBarrierPegHeight(width, height, thickness) = getBarrierPegInnerHeight(width, height) + thickness;

/**
 * Gets the outer length of the shape of a straight barrier.
 * @param Number length - The length of the barrier.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @returns Number
 */
function getStraightBarrierLength(length, width, height) = length + getBarrierLinkLength(width, height);

/**
 * Gets the outer width of the shape of a straight barrier.
 * @param Number length - The length of the barrier.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @returns Number
 */
function getStraightBarrierWidth(length, width, height) = width;

/**
 * Gets the outer length of the shape of a curved barrier.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The extrusion angle.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @returns Number
 */
function getCurvedBarrierLength(radius, angle, width, height) =
    getChordLength(angle, radius + width / 2) +
    getBarrierLinkLength(width, height) * cos(angle / 2) +
    (getBarrierLinkWidth(width, height) - width) / 2 * cos(RIGHT - angle / 2)
;

/**
 * Gets the outer width of the shape of a curved barrier.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The extrusion angle.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @returns Number
 */
function getCurvedBarrierWidth(radius, angle, width, height) =
    getChordHeight(angle, radius + width / 2) + width * sin(RIGHT - angle / 2)
;
