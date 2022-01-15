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
 * Ready to print track part: a couple of straight barrier chunks, with male and female variants.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../config/setup.scad>

/**
 * Gets the length of the final shape for the straight barrier chunks, with male and female variants.
 * @returns Number
 */
function straightBarrierChunkLength() =
    getStraightBarrierMaleLength(length=barrierLength, width=barrierWidth, height=barrierHeight)
;

/**
 * Gets the width of the final shape for the straight barrier chunks, with male and female variants.
 * @returns Number
 */
function straightBarrierChunkWidth() = getPrintInterval(
    getStraightBarrierMaleWidth(length=barrierLength, width=barrierWidth, height=barrierHeight) +
    getStraightBarrierFemaleWidth(length=barrierLength, width=barrierWidth, height=barrierHeight)
);

/**
 * Gets the horizontal interval to place the final shape for the straight barrier chunks, with male and female variants.
 * @returns Number
 */
function straightBarrierChunkIntervalX() = getPrintInterval(straightBarrierChunkLength());

/**
 * Gets the vertical interval to place the final shape for the straight barrier chunks, with male and female variants.
 * @returns Number
 */
function straightBarrierChunkIntervalY() = getPrintInterval(straightBarrierChunkWidth());

/**
 * Defines the final shape for the straight barrier chunks, with male and female variants.
 */
module straightBarrierChunk() {
    interval = getPrintInterval(barrierWidth) / 2;

    translateY(-interval) {
        straightBarrierMale(
            length = barrierLength,
            width = barrierWidth,
            height = barrierHeight,
            diameter = fastenerDiameter,
            headDiameter = fastenerHeadDiameter,
            headHeight = fastenerHeadHeight
        );
    }

    translateY(interval) {
        straightBarrierFemale(
            length = barrierLength,
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
    straightBarrierChunk();

    // Uncomment the next line to cut a sample from the object
    // #rectangle([straightBarrierChunkLength(), straightBarrierChunkWidth()]);
}
