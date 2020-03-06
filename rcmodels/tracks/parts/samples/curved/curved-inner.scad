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
 * A sample for an inner curve track part.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../../config/setup.scad>

/**
 * Gets the curve ratio of the final shape for an inner curve.
 * @returns Number
 */
function finalInnerCurvedBarrierSampleRatio() = getInnerCurveRatio(trackSectionLength, trackRadius);

/**
 * Gets the length of the final shape for an inner curve.
 * @returns Number
 */
function finalInnerCurvedBarrierSampleLength() =
    getCurvedBarrierLength(
        length = sampleSize,
        width = getBarrierHolderWidth(sampleBase),
        base = sampleBase,
        ratio = finalInnerCurvedBarrierSampleRatio()
    )
;

/**
 * Gets the width of the final shape for an inner curve.
 * @returns Number
 */
function finalInnerCurvedBarrierSampleWidth() =
    getCurvedBarrierWidth(
        length = sampleSize,
        width = getBarrierHolderWidth(sampleBase),
        base = sampleBase,
        ratio = finalInnerCurvedBarrierSampleRatio()
    )
;

/**
 * Gets the horizontal interval of the final shape for an inner curve.
 * @returns Number
 */
function finalInnerCurvedBarrierSampleIntervalX() =
    getPrintInterval(
        finalInnerCurvedBarrierSampleLength()
    )
;

/**
 * Gets the vertical interval of the final shape for an inner curve.
 * @returns Number
 */
function finalInnerCurvedBarrierSampleIntervalY() =
    getPrintInterval(
        getBarrierHolderWidth(sampleBase)
    )
;

/**
 * Defines the final shape for an inner curve.
 */
module finalInnerCurvedBarrierSample() {
    curvedBarrierMain(
        length = sampleSize,
        thickness = barrierBodyThickness,
        base = sampleBase,
        ratio = finalInnerCurvedBarrierSampleRatio(),
        right = rightOriented
    );
}

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0])
    finalInnerCurvedBarrierSample();
}
