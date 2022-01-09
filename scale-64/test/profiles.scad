/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2022 Jean-Sebastien CONAN
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
 * A race track system for 1/64 to 1/76 scale RC cars.
 *
 * Test the profile shapes.
 *
 * @author jsconan
 */

// Import the project's setup.
include <setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {

    distributeGrid(intervalX=[barrierWidth + printInterval, 0, 0], intervalY=[0, barrierHeight + printInterval, 0], line=2, center=true) {

        // test the barrier link profile
        barrierLinkProfile(
            width = barrierWidth,
            height = barrierHeight,
            distance = printTolerance
        );

        // test the barrier fastening hole profile
        barrierFastenerHoleProfile(
            height = barrierHeight,
            diameter = fastenerDiameter,
            headDiameter = fastenerHeadDiameter,
            headHeight = fastenerHeadHeight,
            distance = printTolerance
        );

        // test the barrier profile
        barrierProfile(
            width = barrierWidth,
            height = barrierHeight,
            distance = printTolerance
        );

    }
}
