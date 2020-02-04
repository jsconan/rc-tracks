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
 * Test the straight barrier shapes.
 *
 * @author jsconan
 * @version 0.2.0
 */

// Import the project's setup.
include <setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=mode) {

    distributeGrid(intervalX=[length, 0, 0], intervalY=[0, height, 0], center=true) {

        // test the barrier link shape
        barrierLink(
            height = 5,
            base = base,
            distance = tolerance,
            center = false
        );

        // test the barrier notch shape for a straight track element
        barrierNotch(
            thickness = thickness,
            base = base,
            distance = tolerance,
            interval = length,
            count = 2,
            center = true
        );

        // test the barrier body shape
        barrierBody(
            length = length,
            height = height,
            thickness = thickness,
            base = base,
            notches = 2
        );

        // test the barrier body shape for the remaing of a curve
        barrierBody(
            length = getCurveRemainingLength(length),
            height = height,
            thickness = thickness,
            base = base,
            notches = 1
        );

        // test the barrier holder shape for a straight track element
        straightBarrierHolder(
            length = length,
            thickness = thickness,
            base = base
        );

        // test the arch tower shape
        rotateZ(-90) {
            archTower(
                wall = base,
                height = height,
                base = base,
                thickness = thickness
            );
        }

        // test the wire clip profile
        wireClip(
            wall = wall,
            height = clip,
            base = base,
            thickness = thickness
        );

        // test the arch tower shape with holders, left side
        archTowerWidthHolder(
            wall = wall * 2,
            length = length,
            height = height,
            base = base,
            thickness = thickness,
            right = false
        );

        // test the arch tower shape with holders, right side
        archTowerWidthHolder(
            wall = wall * 2,
            length = length,
            height = height,
            base = base,
            thickness = thickness,
            right = true
        );

    }
}
