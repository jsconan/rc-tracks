/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2020-2022 Jean-Sebastien CONAN
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
 * A race track system for 1/24 to 1/32 scale RC cars.
 *
 * A sample for a U-turn curve track part.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../../config/setup.scad>

/**
 * Gets the size of the gap between the 2 sides of the final shape for a U-turn curve.
 * @returns Number
 */
function finalUTurnCurvedBarrierSampleGap() = minWidth * 2;

/**
 * Gets the length of the final shape for a U-turn curve.
 * @returns Number
 */
function finalUTurnCurvedBarrierSampleLength() =
    getUTurnBarrierLength(
        length = sampleSize,
        width = getBarrierHolderWidth(sampleBase),
        base = sampleBase,
        gap = finalUTurnCurvedBarrierSampleGap()
    )
;

/**
 * Gets the width of the final shape for a U-turn curve.
 * @returns Number
 */
function finalUTurnCurvedBarrierSampleWidth() =
    getUTurnBarrierWidth(
        width = getBarrierHolderWidth(sampleBase),
        base = sampleBase,
        gap = finalUTurnCurvedBarrierSampleGap()
    )
;

/**
 * Gets the horizontal interval of the final shape for a U-turn curve.
 * @returns Number
 */
function finalUTurnCurvedBarrierSampleIntervalX() =
    getPrintInterval(
        finalUTurnCurvedBarrierSampleLength()
    )
;

/**
 * Gets the vertical interval of the final shape for a U-turn curve.
 * @returns Number
 */
function finalUTurnCurvedBarrierSampleIntervalY() =
    getPrintInterval(
        finalUTurnCurvedBarrierSampleWidth()
    )
;

/**
 * Draws the shape of a barrier border for a U-Turn.
 * @param Number length - The length of a track element.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number gap - The distance between the two side of the U-turn.
 * @param Number right - Is it the right or the left part of the track element that is added first?
 */
module uTurnSample(length, thickness, base, gap, right = false) {
    linkHeight = getBarrierHolderLinkHeight(base);
    interval = (getBarrierHolderWidth(base) + gap) / 2;
    dir = right ? -1 : 1;
    length = length / 2;

    translateY(interval * dir) {
        straightLinkMale(length=length, linkHeight=linkHeight, base=base) {
            extrudeStraightProfile(length=length) {
                barrierHolderProfile(
                    base = base,
                    thickness = thickness
                );
            }
        }
    }
    translateY(-interval * dir) {
        rotateZ(180) {
            straightLinkFemale(length=length, linkHeight=linkHeight, base=base) {
                extrudeStraightProfile(length=length) {
                    barrierHolderProfile(
                        base = base,
                        thickness = thickness
                    );
                }
            }
        }
    }
    translateX(length / 2) {
        rotateZ(270) {
            extrudeCurvedProfile(radius=interval, angle=180) {
                barrierHolderProfile(
                    base = base,
                    thickness = thickness
                );
            }
        }
    }
}

/**
 * Defines the final shape for a U-turn curve.
 */
module finalUTurnCurvedBarrierSample() {
    uTurnSample(
        length = sampleSize,
        thickness = barrierBodyThickness,
        base = sampleBase,
        gap = finalUTurnCurvedBarrierSampleGap(),
        right = rightOriented
    );
}

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0])
    finalUTurnCurvedBarrierSample();
}
