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
 * Ready to print track part: a couple of curved barrier chunks for the outer curve, with male and female variants.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../config/setup.scad>

/**
 * Gets the size ratio for the outer curve barrier chunks.
 * @returns Number
 */
function largeCurvedBarrierChunkOuterRatio() = 2;

/**
 * Gets the radius for the outer curve barrier chunks.
 * @returns Number
 */
function largeCurvedBarrierChunkOuterRadius() = getCurveOuterRadius(trackSectionLength, trackSectionWidth, largeCurvedBarrierChunkOuterRatio()) + barrierWidth / 2;

/**
 * Gets the curve angle for the outer curve barrier chunks.
 * @returns Number
 */
function largeCurvedBarrierChunkOuterAngle() =
    let(
        ratio = largeCurvedBarrierChunkOuterRatio()
    )
    getCurveAngle(ratio) / getCurveOuterBarrierChunks(barrierChunks, ratio)
;

/**
 * Gets the length of the final shape for the outer curve barrier chunks, with male and female variants.
 * @returns Number
 */
function largeCurvedBarrierChunkOuterLength() =
    getCurvedBarrierMaleLength(radius=largeCurvedBarrierChunkOuterRadius(), angle=largeCurvedBarrierChunkOuterAngle(), width=barrierWidth, height=barrierHeight)
;

/**
 * Gets the width of the final shape for the outer curve barrier chunks, with male and female variants.
 * @returns Number
 */
function largeCurvedBarrierChunkOuterWidth() =
    let(
        radius = largeCurvedBarrierChunkOuterRadius(),
        angle = largeCurvedBarrierChunkOuterAngle()
    )
    getPrintInterval(
        getCurvedBarrierMaleWidth(radius=radius, angle=angle, width=barrierWidth, height=barrierHeight) +
        getCurvedBarrierFemaleWidth(radius=radius, angle=angle, width=barrierWidth, height=barrierHeight)
    )
;

/**
 * Gets the horizontal interval to place the final shape for the outer curve barrier chunks, with male and female variants.
 * @returns Number
 */
function largeCurvedBarrierChunkOuterIntervalX() = getPrintInterval(largeCurvedBarrierChunkOuterLength());

/**
 * Gets the vertical interval to place the final shape for the outer curve barrier chunks, with male and female variants.
 * @returns Number
 */
function largeCurvedBarrierChunkOuterIntervalY() = getPrintInterval(largeCurvedBarrierChunkOuterWidth());

/**
 * Defines the final shape for the outer curve barrier chunks, with male and female variants.
 */
module largeCurvedBarrierChunkOuter() {
    ratio = largeCurvedBarrierChunkOuterRatio();
    radius = largeCurvedBarrierChunkOuterRadius();
    angle = largeCurvedBarrierChunkOuterAngle();
    interval = getPrintInterval(barrierWidth) / 2;

    translateY(-interval) {
        curvedBarrierMale(
            radius = radius,
            angle = angle,
            width = barrierWidth,
            height = barrierHeight,
            diameter = fastenerDiameter,
            headDiameter = fastenerHeadDiameter,
            headHeight = fastenerHeadHeight
        );
    }

    translateY(interval) {
        curvedBarrierFemale(
            radius = radius,
            angle = angle,
            width = barrierWidth,
            height = barrierHeight,
            diameter = fastenerDiameter,
            headDiameter = fastenerHeadDiameter,
            headHeight = fastenerHeadHeight
        );
    }
}

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    // sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0])
    largeCurvedBarrierChunkOuter();

    // Uncomment the next line to debug
    // #rectangle([largeCurvedBarrierChunkOuterLength(), largeCurvedBarrierChunkOuterWidth()]);
}
