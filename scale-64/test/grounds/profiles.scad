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
 * Test the profiles for the ground tiles.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {

    distributeGrid(intervalX=[getPrintInterval(barrierWidth), 0, 0], intervalY=[0, getPrintInterval(barrierHeight), 0], line=2, center=true) {

        // test the barrier peg hole profile
        barrierPegHoleProfile(
            width = barrierWidth,
            height = barrierHeight,
            thickness = trackGroundThickness,
            distance = printTolerance
        );

        // test the curved track ground profile with a size ratio of 2
        curvedGroundProfile(
            length = max(barrierWidth, barrierHeight) / 2,
            width = min(barrierWidth, barrierHeight) / 2,
            angle = CURVE_ANGLE,
            ratio = 2
        );

        // test the curved track ground profile with a size ratio of 1
        curvedGroundProfile(
            length = max(barrierWidth, barrierHeight) / 2,
            width = min(barrierWidth, barrierHeight) / 2,
            angle = CURVE_ANGLE,
            ratio = 1
        );

        // test the enlarged curve track ground profile
        enlargedCurveGroundProfile(
            length = max(barrierWidth, barrierHeight) / 2,
            width = min(barrierWidth, barrierHeight) / 2,
            ratio = 1
        );

        // test the starting block profile
        startingBlockProfile(
            length = max(barrierWidth, barrierHeight),
            width = min(barrierWidth, barrierHeight) / 2,
            thickness = getBarrierBaseUnit(barrierWidth, barrierHeight) / 2,
            distance = printTolerance
        );

        // test the finish line profile
        finishLineProfile(
            length = max(barrierWidth, barrierHeight),
            width = min(barrierWidth, barrierHeight) / 2,
            lines = 4,
            distance = printTolerance
        );

    }
}
