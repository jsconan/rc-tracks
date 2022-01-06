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
 * Test the accessories shapes.
 *
 * @author jsconan
 */

// Import the project's setup.
include <setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=mode) {

    distributeGrid(intervalX=[length + printInterval, 0, 0], intervalY=[0, height, 0], line=2, center=true) {

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

        // test the accessory bent mast shape
        bentMast(
            width = base,
            height = [base, height / 2],
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
        accessoryStraightMast(
            width = base,
            height = height,
            wall = wall,
            base = base,
            thickness = thickness
        );

        // test the bent accessory clip shape
        accessoryBentMast(
            width = base,
            height = [base, height / 2],
            wall = wall,
            base = base,
            thickness = thickness
        );

        // test the accessory flag shape, straight
        accessoryFlag(
            width = width,
            height = height,
            thickness = thickness,
            mast = base,
            wave = 0
        );

        // test the accessory flag shape, wavy
        accessoryFlag(
            width = width,
            height = height,
            thickness = thickness,
            mast = base,
            wave = base
        );

    }
}
