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
 * Work in progress.
 *
 * @author jsconan
 * @version 0.1.0
 */

// Import the project's setup.
include <../config/setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // test the barrier profile
    *barrierHolderProfile(
        slotWidth = getBarrierBodyThickness(),
        slotDepth = getBarrierHolderDepth(),
        base = getBarrierHolderBase()
    );
    // test the barrier notch profile
    *barrierNotchProfile(
        slotDepth = getBarrierHolderDepth(),
        base = getBarrierNotchBase(),
        direction = -1,
        negative = true
    );
    // test the barrier notches profile
    *barrierNotchesProfile(
        length = trackSectionSize / 2,
        slotDepth = getBarrierHolderDepth(),
        base = getBarrierNotchBase(),
        negative = true
    );
    // test the barrier hook shape
    *barrierHook(
        base = getBarrierNotchBase(),
        thickness = getBarrierNotchBase(),
        negative=false
    );
    // test the barrier notch shape
    *barrierNotch(
        thickness = getBarrierBodyThickness(),
        slotDepth = getBarrierHolderDepth(),
        base = getBarrierNotchBase(),
        direction = -1,
        negative = true,
        center = true
    );
    // test the barrier notches shape
    *barrierNotches(
        length = trackSectionSize,
        thickness = getBarrierBodyThickness(),
        slotDepth = getBarrierHolderDepth(),
        base = getBarrierNotchBase(),
        negative = true,
        center = true
    );
    // test the barrier notches shape for a full chunk
    *barrierNotchesFull(
        length = trackSectionSize,
        thickness = getBarrierBodyThickness(),
        slotDepth = getBarrierHolderDepth(),
        base = getBarrierNotchBase(),
        negative = true,
        center = true
    );
    // test the barrier holder shape for a straight chunk
    *straightBarrierHolder(
        length = trackSectionSize,
        bodyThickness = getBarrierBodyThickness(),
        slotDepth = getBarrierHolderDepth(),
        barrierBase = getBarrierHolderBase(),
        notchBase = getBarrierNotchBase()
    );
    // test the curved barrier notch
    *curveBarrierNotch(
        radius = trackSectionSize,
        thickness = getBarrierBodyThickness(),
        slotDepth = getBarrierHolderDepth(),
        base = getBarrierNotchBase(),
        direction = 1,
        negative = true
    );
    // test the barrier holder shape for a curved chunk
    *curveBarrierHolder(
        length = trackSectionSize,
        bodyThickness = getBarrierBodyThickness(),
        slotDepth = getBarrierHolderDepth(),
        barrierBase = getBarrierHolderBase(),
        notchBase = getBarrierNotchBase(),
        ratio = 1
    );
    // test the barrier body shape for a straight chunk
    *barrierBody(
        length = getCurveRemainingLength(trackSectionSize),
        height = barrierHeight,
        thickness = getBarrierBodyThickness(),
        slotDepth = getBarrierHolderDepth(),
        notchBase = getBarrierNotchBase()
    );
    // test the full barrier body shape for a straight chunk
    *barrierBodyFull(
        length = trackSectionSize,
        height = barrierHeight,
        thickness = getBarrierBodyThickness(),
        slotDepth = getBarrierHolderDepth(),
        notchBase = getBarrierNotchBase()
    );
}
