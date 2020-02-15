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
 * Test the profile shapes.
 *
 * @author jsconan
 */

// Import the project's setup.
include <setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=mode) {

    distributeGrid(intervalX=[length, 0, 0], intervalY=[0, height, 0], line=2, center=true) {

        // test the barrier link profile
        barrierLinkProfile(
            base = base,
            distance = printTolerance
        );

        // test the barrier notch profile
        barrierNotchProfile(
            base = base,
            distance = printTolerance
        );

        // test the barrier holder profile
        barrierHolderProfile(
            base = base,
            thickness = thickness,
            distance = 0
        );

        // test the barrier holder outline
        barrierHolderOutline(
            wall = wall,
            base = base,
            thickness = thickness,
            distance = 0
        );

        // test the barrier clip profile
        clipProfile(
            wall = wall,
            base = base,
            thickness = thickness,
            distance = 0
        );

    }
}
