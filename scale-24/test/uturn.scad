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
 * Test the U-turn elements shapes.
 *
 * @author jsconan
 */

// Import the project's setup.
include <setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=mode) {

    distribute(intervalY=length, center=true) {

        // test the U-turn holder shape, left side
        uTurnBarrierHolder(
            length = length,
            height = height,
            thickness = thickness,
            base = base,
            gap = wall,
            right = false
        );

        // test the U-turn holder shape, right side
        uTurnBarrierHolder(
            length = length,
            height = height,
            thickness = thickness,
            base = base,
            gap = wall,
            right = true
        );

        // test the U-turn unibody shape, left side
        uTurnBarrierUnibody(
            length = length,
            height = height,
            thickness = thickness,
            base = base,
            gap = wall,
            right = false
        );

        // test the U-turn unibody shape, right side
        uTurnBarrierUnibody(
            length = length,
            height = height,
            thickness = thickness,
            base = base,
            gap = wall,
            right = true
        );

        // test the U-turn compensation shape
        uTurnCompensationBarrierUnibody(
            height = height,
            thickness = thickness,
            base = base,
            gap = wall
        );

        // test the U-turn compensation shape
        uTurnCompensationBarrierHolder(
            thickness = thickness,
            base = base,
            gap = wall
        );

        // test the U-turn compensation body shape
        uTurnCompensationBarrierBody(
            length = length,
            height = height,
            thickness = thickness,
            base = base,
            gap = wall
        );

    }
}
