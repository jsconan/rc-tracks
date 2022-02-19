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
 * Test the shapes for the curved barriers.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {

    ratio = 1;
    outerRadius = getCurveOuterRadius(trackSectionLength, trackSectionWidth, ratio) - barrierWidth / 2;
    outerAngle = getCurveAngle(ratio) / getCurveOuterBarrierChunks(barrierChunks, ratio);
    innerRadius = getCurveInnerRadius(trackSectionLength, trackSectionWidth, ratio) + barrierWidth / 2;
    innerAngle = getCurveAngle(ratio) / getCurveInnerBarrierChunks(barrierChunks, ratio);

    distributeGrid(
        intervalX = xAxis3D(getPrintInterval(getCurvedBarrierLength(outerRadius, outerAngle, barrierWidth, barrierHeight))),
        intervalY = yAxis3D(getPrintInterval(getCurvedBarrierWidth(outerRadius, outerAngle, barrierWidth, barrierHeight))),
        line = 1,
        center = true
    ) {

        // test the shape of a curved barrier for the outer radius of a track section
        curvedBarrier(
            radius = outerRadius,
            angle = outerAngle,
            width = barrierWidth,
            height = barrierHeight,
            diameter = fastenerDiameter,
            headDiameter = fastenerHeadDiameter,
            headHeight = fastenerHeadHeight,
            right = false
        );


        // test the shape of a curved barrier for the inner radius of a track section
        curvedBarrier(
            radius = innerRadius,
            angle = innerAngle,
            width = barrierWidth,
            height = barrierHeight,
            diameter = fastenerDiameter,
            headDiameter = fastenerHeadDiameter,
            headHeight = fastenerHeadHeight,
            right = true
        );

    }
}
