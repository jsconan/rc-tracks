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
 * Ready to print track part: a ground tile for a large curved track section.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../config/setup.scad>

/**
 * Defines the final shape for the ground tile of a large curved track section.
 */
module curvedTrackSection() {
    curvedGroundTile(
        length = trackSectionLength,
        width = trackSectionWidth,
        thickness = trackGroundThickness,
        barrierWidth = barrierWidth,
        barrierHeight = barrierHeight,
        barrierChunks = barrierChunks,
        ratio = 2
    );
}

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    // sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0])
    curvedTrackSection();

    // Uncomment the next line to cut a sample from the object
    // #rectangle([trackSectionLength, trackSectionLength]);
}
