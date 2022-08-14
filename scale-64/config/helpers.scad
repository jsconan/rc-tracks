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
 * Local helper functions for the project.
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
function getTrackSectionLength(laneWidth, barrierWidth) = getTrackSectionWidth(laneWidth, barrierWidth) + laneWidth / 4;

/**
 * Computes the width of the track lane from the given track section length and width.
 * @param Number width - The width of a track section.
 * @param Number barrierWidth - The width of the barriers.
 * @returns Number
 */
function getTrackLaneWidth(width, barrierWidth) = width - barrierWidth * 2;

/**
 * Computes the length of a barrier chunk.
 * @param Number laneWidth - The width of a track lane.
 * @param Number barrierWidth - The width of the barriers.
 * @param Number barrierChunks - The number barriers per track section.
 * @returns Number
 */
function getBarrierLength(laneWidth, barrierWidth, barrierChunks) = getTrackSectionLength(laneWidth, barrierWidth) / barrierChunks;

/**
 * Computes the angle of a curve with respect to the ratio.
 * @param Number ratio - The ratio of the curve.
 * @returns Number
 */
function getCurveAngle(ratio) =
    let(
        ratio = abs(ratio),
        angleDivider = ratio < 1 ? 1 / ratio
                     : ratio > 1 && !forceFullTile ? ratio * 2
                     : ratio
    )
    CURVE_ANGLE / angleDivider
;

/**
 * Computes the inner radius of a curve given the ratio.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getCurveInnerRadius(length, width, ratio=1) = length * (abs(ratio) - 1) + (length - width) / 2;

/**
 * Computes the outer radius of a curve given the ratio.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getCurveOuterRadius(length, width, ratio=1) = width + getCurveInnerRadius(length=length, width=width, ratio=ratio);

/**
 * Computes the length of the outer side of an enlarged curved track.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getEnlargedCurveSide(length, width, ratio=1) = length * abs(ratio) / 2;

/**
 * Computes the inner radius of a curve given the ratio.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getEnlargedCurveInnerRadius(length, width, ratio=1) = getCurveInnerRadius(length=length, width=width, ratio=ratio);

/**
 * Computes the outer radius of an enlarged curved track.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getEnlargedCurveOuterRadius(length, width, ratio=1) = getCurveOuterRadius(length=length, width=width, ratio=ratio) - getEnlargedCurveSide(length=length, width=width, ratio=ratio);

/**
 * Computes the coordinates of the center for a raw curve given the ratio.
 * This is useful for translating the tile to its final position.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number [ratio] - The size factor.
 * @returns Vector
 */
function getRawCurveCenter(length, width, ratio=1) =
    let(
        sizeRatio = max(1, ratio),
        angle = getCurveAngle(ratio) / 2,
        minRadius = getCurveInnerRadius(length=length, width=width, ratio=1),
        innerRadius = getCurveInnerRadius(length=length, width=width, ratio=sizeRatio),
        middleRadius = innerRadius + minRadius + width / 2
    )
    [
        cos(angle) * middleRadius,
        sin(angle) * middleRadius
    ]
;

/**
 * Computes the coordinates of the center for a raw enlarged curve given the ratio.
 * This is useful for translating the tile to its final position.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number [ratio] - The size factor.
 * @returns Vector
 */
function getRawEnlargedCurveCenter(length, width, ratio=1) =
    let(
        center = getCurveOuterRadius(length=length, width=width, ratio=ratio) / 2
    )
    [center, center]
;
