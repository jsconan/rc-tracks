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
 * An arch tower that clamp the barrier holders.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../../config/setup.scad>

/**
 * Gets the length of the final shape for a couple of arch towers (male and female)
 * @returns Number
 */
function finalArchTowerLength() =
    getArchTowerLengthMale(
        length = trackSectionLength,
        base = barrierHolderBase,
        wall = archTowerThickness
    )
;

/**
 * Gets the width of the final shape for a couple of arch towers (male and female)
 * @returns Number
 */
function finalArchTowerWidth() =
    getArchTowerWidth(
        base = barrierHolderBase,
        wall = archTowerThickness
    )
;

/**
 * Gets the horizontal interval of the final shape for a couple of arch towers (male and female)
 * @returns Number
 */
function finalArchTowerIntervalX() =
    getPrintInterval(
        finalArchTowerLength()
    )
;

/**
 * Gets the vertical interval of the final shape for a couple of arch towers (male and female)
 * @returns Number
 */
function finalArchTowerIntervalY() =
    2 * getPrintInterval(
        finalArchTowerWidth()
    )
;

/**
 * Defines the final shapes for a couple of arch towers (male and female).
 */
module finalArchTower() {
    distribute([0, finalArchTowerIntervalY() / 2, 0], center=true) {
        archTowerMale(
            length = trackSectionLength,
            thickness = barrierBodyThickness,
            base = barrierHolderBase,
            wall = archTowerThickness
        );
        archTowerFemale(
            length = trackSectionLength,
            thickness = barrierBodyThickness,
            base = barrierHolderBase,
            wall = archTowerThickness
        );
    }
}

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0])
    finalArchTower();
}
