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
 * An arch sample scaled with respect to the size of the track samples.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../../config/setup.scad>

/**
 * Gets the width of a lane with respect to the samples.
 * @returns Number
 */
function getSampleLaneWidth() = trackLaneWidth / trackSectionLength * sampleSize;

/**
 * Gets the thickness of the clip outline..
 * @returns Number
 */
function getSampleWallWidth() = minWidth * 2;

/**
 * Gets the length of the final shape for an arch sample.
 * @returns Number
 */
function finalArchSampleLength() =
    getSampleLaneWidth() +
    getBarrierHolderWidth(sampleBase) +
    getSampleWallWidth() * 2
;

/**
 * Gets the width of the final shape for an arch sample.
 * @returns Number
 */
function finalArchSampleWidth() =
    sampleSize * 1.5 +
    getBarrierHolderHeight(sampleBase) +
    getSampleWallWidth() * 2
;

/**
 * Gets the horizontal interval of the final shape for an arch sample.
 * @returns Number
 */
function finalArchSampleIntervalX() =
    getPrintInterval(
        finalArchSampleLength()
    )
;

/**
 * Gets the vertical interval of the final shape for an arch sample.
 * @returns Number
 */
function finalArchSampleIntervalY() =
    getPrintInterval(
        finalArchSampleWidth()
    )
;

/**
 * Computes the points defining the profile of the arch sample.
 * @param Number length - The length of a track element.
 * @param Number width - The width of a track lane.
 * @returns Vector[]
 */
function getArchSamplePoints(length, width) =
    let(
        start = width / 2,
        radius = length,
        tower = length / 2,
        middle = width - 2 * radius
    )
    path([
        ["P", -start, 0],
        ["V", tower],
        ["C", radius, 180, 90],
        ["H", middle],
        ["C", radius, 90, 0],
        ["V", -tower]
    ])
;

/**
 * Draws the shape of the arch sample.
 * @param Number length - The length of a track element.
 * @param Number width - The width of a track lane.
 * @param Number wall - The thickness of the outline.
 */
module archSampleProfile(length, width, wall) {
    distance = wall / 2;

    difference() {
        polygon(outline(getArchSamplePoints(length, width), -distance), convexity = 10);
        polygon(outline(getArchSamplePoints(length, width), distance), convexity = 10);
        rectangle([width - wall, wall]);
    }
}

/**
 * Defines the final shape for an arch sample.
 */
module finalArchSample() {
    laneWidth = getSampleLaneWidth();
    wallWidth = getSampleWallWidth();

    linear_extrude(height=getBarrierHolderWidth(sampleBase), convexity=10) {
        archSampleProfile(sampleSize, laneWidth, wallWidth);
        repeat(count=2, intervalX=laneWidth, center=true) {
            translateY(-getBarrierHolderHeight(sampleBase) - wallWidth * 2) {
                difference() {
                    barrierHolderOutline(
                        wall = wallWidth,
                        base = sampleBase,
                        thickness = barrierBodyThickness,
                        distance = printTolerance
                    );
                    rectangle([getBarrierHolderWidth(sampleBase) + wallWidth * 3, wallWidth * 2]);
                    rectangle([getBarrierHolderWidth(sampleBase) + printTolerance * 2, wallWidth * 3]);
                }
            }
        }
    }
}

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0])
    finalArchSample();
}
