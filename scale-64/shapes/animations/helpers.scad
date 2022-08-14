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
 * Defines the helper functions for the animations.
 *
 * @author jsconan
 */

/**
 * Gets the list of steps needed to build a straight section.
 * @param Number [ratio] - The size ratio.
 * @returns Vector
 */
function getStraightSectionAnimationSteps(ratio=1) =
    let(
        chunks = getStraightBarrierChunks(barrierChunks, ratio)
    )
    concat(
        [ for (i = [0 : chunks - 1] ) ["peg", i, false] ],
        [ for (i = [0 : chunks - 1] ) ["peg", i, true] ],
        [ ["ground", 0, false] ],
        [ for (i = [0 : chunks - 1] ) ["barrier", i, false] ],
        [ for (i = [0 : chunks - 1] ) ["barrier", i, true] ]
    )
;

/**
 * Gets the list of steps needed to build a curve section.
 * @param Number [ratio] - The size ratio.
 * @returns Vector
 */
function getCurveSectionAnimationSteps(ratio=1) =
    let(
        inner = getCurveInnerBarrierChunks(barrierChunks, ratio),
        outer = getCurveOuterBarrierChunks(barrierChunks, ratio)
    )
    concat(
        [ for (i = [0 : inner - 1] ) ["peg", i, true] ],
        [ for (i = [0 : outer - 1] ) ["peg", i, false] ],
        [ ["ground", 0, false] ],
        [ for (i = [0 : inner - 1] ) ["barrier", i, true] ],
        [ for (i = [0 : outer - 1] ) ["barrier", i, false] ]
    )
;

/**
 * Gets the list of steps needed to build an enlarged curve section.
 * @param Number [ratio] - The size ratio.
 * @returns Vector
 */
function getEnlargedCurveSectionAnimationSteps(ratio=1) =
    let(
        side = getEnlargedCurveSideBarrierChunks(barrierChunks, ratio),
        inner = getEnlargedCurveInnerBarrierChunks(barrierChunks, ratio),
        outer = getEnlargedCurveOuterBarrierChunks(barrierChunks, ratio)
    )
    concat(
        [ for (i = [0 : inner - 1] ) ["peg", "curve", i, true] ],
        [ for (i = [0 : side - 1] ) ["peg", "side", i, true] ],
        [ for (i = [0 : outer - 1] ) ["peg", "curve", i, false] ],
        [ for (i = [0 : side - 1] ) ["peg", "side", i, false] ],
        [ ["ground", "ground", 0, false] ],
        [ for (i = [0 : inner - 1] ) ["barrier", "curve", i, true] ],
        [ for (i = [0 : side - 1] ) ["barrier", "side", i, true] ],
        [ for (i = [0 : outer - 1] ) ["barrier", "curve", i, false] ],
        [ for (i = [0 : side - 1] ) ["barrier", "side", i, false] ]
    )
;

/**
 * Gets the thresholds for an animation.
 * @param String type - The type of the animation. This represents the name of a model.
 * @param Number ratio - The size ratio.
 * @param Vector|Number steps - The number of steps, or the list of steps.
 * @returns Vector
 */
function getAnimationThresholds(type, ratio, steps) =
    let(
        steps = is_list(steps) ? len(steps) : float(steps),
        start = 0,
        present = start + steps,
        end = present + ANIMATION_PRESENTATION_STEPS + ANIMATION_SLIDE_STEPS
    )
    [type, ratio, start, present, end]
;

/**
 * Builds a list of animations, adjusting the stat and end thresholds to make sure they are coming in serie.
 * @param Vector list - The list of animation thresholds to adjust.
 * @returns Vector
 */
function buildAnimationList(list) =
    let(
        list = array(list),
        count = len(list)
    )
    [
        for (i = [0 : count - 1])
            let(
                type = list[i][0],
                ratio = list[i][1],
                start = list[i][2],
                present = list[i][3],
                end = list[i][4],
                last = vsum(i > 0 ? [for (j = [0 : i - 1]) list[j][4]] : [])
            )
            [type, ratio, start + last, present + last, end + last]
    ]
;

/**
 * Gets the overall number of steps to process all animations from the given list.
 * @param Vector list - The list of animation thresholds to sum.
 * @returns Number
 */
function getAnimationSteps(list) =
    let(
        list = array(list),
        count = len(list)
    )
    list[count - 1][4]
;

/**
 * Gets the coordinates and the rotation angle of a straight barrier given its position.
 * @param Number i - The position of the barrier on its side.
 * @param Number [ratio] - The size ratio.
 * @param Boolean [right] - Tells on which side is the male link (default on the left).
 * @returns Vector
 */
function getStraightBarrierCoordinates(i, ratio=1, right=false) =
    let(
        barrierLength = getBarrierLength(trackLaneWidth, barrierWidth, barrierChunks),
        sectionLength = getStraightLength(trackSectionLength, ratio),
        barrierX = right ? (barrierLength - sectionLength) / 2 : (sectionLength - barrierLength) / 2,
        barrierY = (trackSectionWidth - barrierWidth) / 2
    )
    [
        barrierX + i * barrierLength * (right ? 1 : -1),
        barrierY * (right ? -1 : 1),
        right ? STRAIGHT : 0
    ]
;

/**
 * Gets the coordinates and the rotation angle of a curved barrier given its position.
 * @param Number i - The position of the barrier on its side.
 * @param Number [ratio] - The size ratio.
 * @param Boolean [inner] - Tells if this is the inner or the outer curve (default: inner).
 * @returns Vector
 */
function getCurveBarrierCoordinates(i, ratio=1, inner=false) =
    let(
        sizeRatio = max(1, ratio),
        angle = getCurveAngle(ratio),
        placementAngle = CURVE_ANGLE - angle,
        radius = inner ? getCurveInnerBarrierPosition(length=trackSectionLength, width=trackSectionWidth, barrierWidth=barrierWidth, ratio=sizeRatio)
                       : getCurveOuterBarrierPosition(length=trackSectionLength, width=trackSectionWidth, barrierWidth=barrierWidth, ratio=sizeRatio),
        chunks = inner ? getCurveInnerBarrierChunks(barrierChunks, ratio)
                       : getCurveOuterBarrierChunks(barrierChunks, ratio),
        center = getRawCurveCenter(length=trackSectionLength, width=trackSectionWidth, ratio=ratio),
        interval = angle / chunks,
        positionAngle = interval * (i + .5),
        positionX = radius * cos(inner ? angle - positionAngle : positionAngle) - center.x,
        positionY = radius * sin(inner ? angle - positionAngle : positionAngle) - center.y,
        rotation = placementAngle + (inner ? angle - interval * (i + 1) : interval * i) - getCurveRotationAngle(interval),
        position = rotp([positionX, positionY], placementAngle)
    )
    [position.x, position.y, rotation]
;

/**
 * Gets the coordinates and the rotation angle of an enlarged curved barrier given its position.
 * @param Number i - The position of the barrier on its side.
 * @param Number [ratio] - The size ratio.
 * @param Boolean [inner] - Tells if this is the inner or the outer curve (default: inner).
 * @returns Vector
 */
function getEnlargedCurveBarrierCoordinates(i, ratio=1, inner=false) =
    let(
        angle = CURVE_ANGLE,
        innerRadius = getCurveInnerRadius(length=trackSectionLength, width=trackSectionWidth, ratio=ratio),
        outerRadius = getCurveOuterRadius(length=trackSectionLength, width=trackSectionWidth, ratio=ratio),
        side = inner ? 0 : getEnlargedCurveSide(length=trackSectionLength, width=trackSectionWidth, ratio=ratio),
        radius = inner ? getEnlargedCurveInnerBarrierPosition(length=trackSectionLength, width=trackSectionWidth, barrierWidth=barrierWidth, ratio=ratio)
                       : getEnlargedCurveOuterBarrierPosition(length=trackSectionLength, width=trackSectionWidth, barrierWidth=barrierWidth, ratio=ratio),
        chunks = inner ? getEnlargedCurveInnerBarrierChunks(barrierChunks, ratio)
                       : getEnlargedCurveOuterBarrierChunks(barrierChunks, ratio),
        center = getRawEnlargedCurveCenter(length=trackSectionLength, width=trackSectionWidth, ratio=ratio),
        interval = angle / chunks,
        positionAngle = interval * (i + .5),
        positionX = radius * cos(inner ? angle - positionAngle : positionAngle) + side - center.x,
        positionY = radius * sin(inner ? angle - positionAngle : positionAngle) + side - center.y,
        rotation = (inner ? angle - interval * (i + 1) : interval * i) - getCurveRotationAngle(interval)
    )
    [positionX, positionY, rotation]
;

/**
 * Gets the coordinates and the rotation angle of a side barrier for an enlarged curve given its position.
 * @param Number i - The position of the barrier on its side.
 * @param Number [ratio] - The size ratio.
 * @param Boolean [right] - Tells on which side is the barrier (default on the left).
 * @returns Vector
 */
function getEnlargedCurveSideBarrierCoordinates(i, ratio=1, right=false) =
    let(
        outerRadius = getCurveOuterRadius(length=trackSectionLength, width=trackSectionWidth, ratio=ratio),
        sideOffset = outerRadius / 2,
        sidePosition = getEnlargedCurveSideBarrierPosition(length=trackSectionLength, width=trackSectionWidth, barrierWidth=barrierWidth, ratio=ratio) - sideOffset,
        barrierLength = getBarrierLength(trackLaneWidth, barrierWidth, barrierChunks),
        sectionLength = getStraightLength(trackSectionLength, ratio),
        barrierX = (sectionLength - barrierLength) / 2 - sideOffset,
        positionX = right ? sidePosition : barrierX - i * barrierLength,
        positionY = right ? (barrierLength - outerRadius) / 2 + i * barrierLength : (outerRadius - barrierWidth) / 2,
        rotation = right ? -RIGHT : 0
    )

    [positionX, positionY, rotation]
;
