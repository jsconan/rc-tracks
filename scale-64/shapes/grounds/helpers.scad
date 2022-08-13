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
 * Defines the helper functions for the ground tiles.
 *
 * @author jsconan
 */

/**
 * Computes the position of the inner barrier of a curve given the ratio.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number barrierWidth - The width of the barriers.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getCurveInnerBarrierPosition(length, width, barrierWidth, ratio=1) = getCurveInnerRadius(length=length, width=width, ratio=ratio) + barrierWidth / 2;

/**
 * Computes the position of the outer barrier of a curve given the ratio.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number barrierWidth - The width of the barriers.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getCurveOuterBarrierPosition(length, width, barrierWidth, ratio=1) = getCurveOuterRadius(length=length, width=width, ratio=ratio) - barrierWidth / 2;

/**
 * Computes the position of the side barrier of an enlarged curve given the ratio.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number barrierWidth - The width of the barriers.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getEnlargedCurveSideBarrierPosition(length, width, barrierWidth, ratio=1) = getCurveOuterRadius(length=length, width=width, ratio=ratio) - barrierWidth / 2;

/**
 * Computes the position of the inner barrier of an enlarged curve given the ratio.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number barrierWidth - The width of the barriers.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getEnlargedCurveInnerBarrierPosition(length, width, barrierWidth, ratio=1) = getEnlargedCurveInnerRadius(length=length, width=width, ratio=ratio) + barrierWidth / 2;

/**
 * Computes the position of the outer barrier of an enlarged curve given the ratio.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number barrierWidth - The width of the barriers.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getEnlargedCurveOuterBarrierPosition(length, width, barrierWidth, ratio=1) = getEnlargedCurveOuterRadius(length=length, width=width, ratio=ratio) - barrierWidth / 2;

/**
 * Computes the number of barrier chunks for a straight section given the ratio.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getStraightBarrierChunks(barrierChunks, ratio=1) = barrierChunks * abs(ratio);

/**
 * Computes the number of barrier chunks for an inner curved section given the ratio.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getCurveInnerBarrierChunks(barrierChunks, ratio=1) =
    let(
        ratio = abs(ratio),
        chunksDivider = ratio < 2 || !forceFullTile ? 2 : 1
    )
    ratio < 1 ? 1 : barrierChunks / chunksDivider
;

/**
 * Computes the number of barrier chunks for an outer curved section given the ratio.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getCurveOuterBarrierChunks(barrierChunks, ratio=1) =
    let(
        ratio = abs(ratio),
        chunksDivider = ratio == 1 || (ratio > 1 && forceFullTile) ? 1 : 2
    )
    barrierChunks / chunksDivider
;

/**
 * Computes the number of barrier chunks for the straight sides of large curve track.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getEnlargedCurveSideBarrierChunks(barrierChunks, ratio=1) = getStraightBarrierChunks(barrierChunks, ratio) / 2;

/**
 * Computes the number of barrier chunks for the inner curve of large curve track.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getEnlargedCurveInnerBarrierChunks(barrierChunks, ratio=1) =
    let(
        ratio = abs(ratio)
    )
    ratio == 1 ? barrierChunks / 2 : barrierChunks * ratio
;

/**
 * Computes the number of barrier chunks for the outer curve of large curve track.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getEnlargedCurveOuterBarrierChunks(barrierChunks, ratio=1) = barrierChunks / 2 * abs(ratio);
