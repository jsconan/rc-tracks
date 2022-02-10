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
 * Test the straight elements shapes.
 *
 * @author jsconan
 */

// Import the project's setup.
include <setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {

    distributeGrid(
        intervalX = xAxis3D(getPrintInterval(getStraightBarrierLength(barrierLength, barrierWidth, barrierHeight))),
        intervalY = yAxis3D(getPrintInterval(getStraightBarrierWidth(barrierLength, barrierWidth, barrierHeight))),
        line = 1,
        center = true
    ) {

        // test the shape of a straight barrier body
        straightBarrierBody(
            length = barrierLength,
            width = barrierWidth,
            height = barrierHeight
        );

        // test the shape of a straight barrier
        straightBarrier(
            length = barrierLength,
            width = barrierWidth,
            height = barrierHeight,
            diameter = fastenerDiameter,
            headDiameter = fastenerHeadDiameter,
            headHeight = fastenerHeadHeight
        );

    }
}
