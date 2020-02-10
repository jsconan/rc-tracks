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
 * Test the straight elements shapes.
 *
 * @author jsconan
 * @version 0.2.0
 */

// Import the project's setup.
include <setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=mode) {

    distributeGrid(intervalX=[length * 1.5, 0, 0], intervalY=[0, height * 1.5, 0], line=3, center=true) {

        // test the barrier body shape
        barrierBody(
            length = length,
            height = height,
            thickness = thickness,
            base = base,
            notches = 2
        );

        // test the main shape of the barrier holder for a straight track element
        straightBarrierMain(
            length = length,
            thickness = thickness,
            base = base
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
            base = base,
            ratio = 1
        );

        // test the arch tower shape with holders, left side
        archTower(
            wall = wall * 2,
            length = length,
            base = base,
            thickness = thickness,
            right = false
        );

        // test the arch tower shape with holders, right side
        archTower(
            wall = wall * 2,
            length = length,
            base = base,
            thickness = thickness,
            right = true
        );

    }
}
