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
 * Refines the configuration values.
 *
 * @author jsconan
 */

/**
 * Computes the overall width of a track section.
 * @param Number laneWidth - The width of a track lane.
 * @param Number barrierWidth - The width of the barriers.
 * @returns Number
 */
function getTrackSectionWidth(laneWidth, barrierWidth) = laneWidth + barrierWidth * 2;

/**
 * Computes the overall length of a track section.
 * @param Number laneWidth - The width of a track lane.
 * @param Number barrierWidth - The width of the barriers.
 * @returns Number
 */
function getTrackSectionLength(laneWidth, barrierWidth) = getTrackSectionWidth(laneWidth, barrierWidth) + barrierWidth * 5;

/**
 * Computes the length of a barrier chunk.
 * @param Number laneWidth - The width of a track lane.
 * @param Number barrierWidth - The width of the barriers.
 * @param Number barrierChunks - The number barriers per track section.
 * @returns Number
 */
function getBarrierLength(laneWidth, barrierWidth, barrierChunks) = getTrackSectionLength(laneWidth, barrierWidth) / barrierChunks;

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
function getBarrierLinkLength(width, height, distance = 0) = getBarrierBaseUnit(width, height) * 1.5 + distance;

/**
 * Computes the outer width of a barrier link.
 * @param Number width - The width of the barriers.
 * @param Number height - The height of the barriers.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 * @returns Number
 */
function getBarrierLinkWidth(width, height, distance = 0) = (getBarrierBaseUnit(width, height) + distance) * 2;

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
 * Computes the angle of a curve with respect to the ratio.
 * @param Number ratio - The ratio of the curve.
 * @returns Number
 */
function getCurveAngle(ratio) = CURVE_ANGLE / ratio;

/**
 * Computes the rotation angle used to place a curve.
 * @param Number angle - The angle of the curve.
 * @returns Number
 */
function getCurveRotationAngle(angle) = 45 + (CURVE_ANGLE - angle) / 2;

/**
 * Computes the inner radius of a curve given the ratio.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getCurveInnerRadius(length, width, ratio) = (length * ratio - width) / 2;

/**
 * Computes the outer radius of a curve given the ratio.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getCurveOuterRadius(length, width, ratio) = width + getCurveInnerRadius(length=length, width=width, ratio=ratio);

/**
 * Computes the length of the outer side of a large curved track.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getLargeCurveSide(length, width, ratio) = length * ratio / 2;

/**
 * Computes the inner radius of a curve given the ratio.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getLargeCurveInnerRadius(length, width, ratio) = getCurveInnerRadius(length=length, width=width, ratio=ratio);

/**
 * Computes the outer radius of a large curved track.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getLargeCurveOuterRadius(length, width, ratio) = getCurveOuterRadius(length=length, width=width, ratio=ratio) - getLargeCurveSide(length=length, width=width, ratio=ratio);

/**
 * Computes the number of barrier chunks for a straight section given the ratio.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getStraightBarrierChunks(barrierChunks, ratio) = barrierChunks * ratio;

/**
 * Computes the number of barrier chunks for an inner curved section given the ratio.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getCurveInnerBarrierChunks(barrierChunks, ratio) = min(ratio * 2, barrierChunks);

/**
 * Computes the number of barrier chunks for an outer curved section given the ratio.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getCurveOuterBarrierChunks(barrierChunks, ratio) = barrierChunks;

/**
 * Computes the number of barrier chunks for the straight sides of large curve track.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getLargeCurveSideBarrierChunks(barrierChunks, ratio) = getStraightBarrierChunks(barrierChunks, ratio) / 2;

/**
 * Computes the number of barrier chunks for the inner curve of large curve track.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getLargeCurveInnerBarrierChunks(barrierChunks, ratio) = getCurveInnerBarrierChunks(barrierChunks, ratio) * ratio;

/**
 * Computes the number of barrier chunks for the outer curve of large curve track.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getLargeCurveOuterBarrierChunks(barrierChunks, ratio) = getCurveOuterBarrierChunks(barrierChunks, ratio) / 2;

// The overall length of a track section (size of a tile in the track)
trackSectionLength = getTrackSectionLength(trackLaneWidth, barrierWidth);

// The overall width of a track section (size of a tile in the track)
trackSectionWidth = getTrackSectionWidth(trackLaneWidth, barrierWidth);

// The length of a barrier chunk
barrierLength = getBarrierLength(trackLaneWidth, barrierWidth, barrierChunks);

// The angle of a typical curve
CURVE_ANGLE = RIGHT;

// The number of fastener holes per barrier chunks
FASTENER_HOLES = 1;
