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
 * A unibody barrier to compensate a U-turn track part.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../../config/setup.scad>

/**
 * Gets the size of the gap between the 2 sides of the final shape for a U-turn curve.
 * @returns Number
 */
function finalUTurnCompensationBarrierUnibodyGap() = archTowerThickness * 2;

/**
 * Gets the length of the final shape for a U-turn compensation unibody barrier.
 * @returns Number
 */
function finalUTurnCompensationBarrierUnibodyLength() =
    getUTurnCompensationBarrierLength(
        width = getBarrierUnibodyWidth(barrierHolderBase),
        base = barrierHolderBase,
        gap = finalUTurnCompensationBarrierUnibodyGap()
    )
;

/**
 * Gets the width of the final shape for a U-turn compensation unibody barrier.
 * @returns Number
 */
function finalUTurnCompensationBarrierUnibodyWidth() = getBarrierUnibodyWidth(barrierHolderBase);

/**
 * Gets the horizontal interval of the final shape for a U-turn compensation unibody barrier.
 * @returns Number
 */
function finalUTurnCompensationBarrierUnibodyIntervalX() =
    getPrintInterval(
        finalUTurnCompensationBarrierUnibodyLength()
    )
;

/**
 * Gets the vertical interval of the final shape for a U-turn compensation unibody barrier.
 * @returns Number
 */
function finalUTurnCompensationBarrierUnibodyIntervalY() =
    getPrintInterval(
        finalUTurnCompensationBarrierUnibodyWidth()
    )
;

/**
 * Defines the final shape for a U-turn compensation unibody barrier.
 */
module finalUTurnCompensationBarrierUnibody() {
    uTurnCompensationBarrierUnibody(
        height = barrierHeight,
        thickness = barrierBodyThickness,
        base = barrierHolderBase,
        gap = finalUTurnCompensationBarrierUnibodyGap()
    );
}

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0])
    finalUTurnCompensationBarrierUnibody();
}
