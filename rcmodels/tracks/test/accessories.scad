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
 * Test the accessories shapes.
 *
 * @author jsconan
 */

// Import the project's setup.
include <setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=mode) {

    distributeGrid(intervalX=[length, 0, 0], intervalY=[0, height, 0], line=2, center=true) {

        // test the cable clip shape
        cableClip(
            height = clip,
            wall = wall,
            base = base,
            thickness = thickness
        );

        // test the accessory mast shape
        mast(
            width = base,
            height = height,
            distance = 0
        );

        // test the accessory rings shape
        mastRings(
            width = base,
            height = base,
            wall = base,
            interval = height / 2,
            count = 2,
            distance = printTolerance,
            center = true
        );

        // test the accessory clip shape
        accessoryMast(
            width = base,
            height = height,
            wall = wall,
            base = base,
            thickness = thickness
        );

        // test the accessory flag shape
        accessoryFlag(
            width = width,
            height = height,
            thickness = thickness,
            ring = wall,
            mast = base
        );

    }
}
