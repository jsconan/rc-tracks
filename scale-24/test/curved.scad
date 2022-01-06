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
 * Test the curved elements shapes.
 *
 * @author jsconan
 */

// Import the project's setup.
include <setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=mode) {

    distributeGrid(
        intervalX = [length * 2, 0, 0],
        intervalY = [0, length * 2, 0],
        line = 2, 
        center = true
    ) {

        // test the main shape of a curved barrier holder, left turned
        curvedBarrierMain(
            length = length,
            thickness = thickness,
            base = base,
            ratio = 1,
            right = false
        );

        // test the main shape of a curved barrier holder, right turned
        curvedBarrierMain(
            length = length,
            thickness = thickness,
            base = base,
            ratio = 1,
            right = true
        );

        // test the shape of the curved barrier holder, left turned
        curvedBarrierHolder(
            length = length,
            thickness = thickness,
            base = base,
            ratio = 1,
            right = false
        );

        // test the shape of the curved barrier holder, right turned
        curvedBarrierHolder(
            length = length,
            thickness = thickness,
            base = base,
            ratio = 1,
            right = true
        );

        // test the shape of a curved unibody barrier, left turned
        curvedBarrierUnibody(
            length = length,
            height = height,
            thickness = thickness,
            base = base,
            ratio = 1,
            right = false
        );

        // test the shape of a curved unibody barrier, right turned
        curvedBarrierUnibody(
            length = length,
            height = height,
            thickness = thickness,
            base = base,
            ratio = 1,
            right = true
        );

    }
}
