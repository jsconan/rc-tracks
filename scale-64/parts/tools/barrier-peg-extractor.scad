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
 * Ready to print track tool: a barrier peg extractor.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

/**
 * Draws the shape of the barrier peg extractor.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number diameter - The diameter of the fastener.
 * @param Number thickness - The thickness of the track ground.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module barrierPegExtractor(width, height, diameter, thickness, distance=0) {
    // Prepare the parameters for the polygon
    pegDiameter = getBarrierPegDiameter(width, height);

    jawLength = pegDiameter * 5;
    jawWidth = pegDiameter * 3;
    radius = pegDiameter / 2;
    handleHeight = thickness * 6;
    handleWidth = jawWidth + (handleHeight + radius + distance) * 2;
    handleLength = jawLength * 2;

    remainingLength = jawLength - radius + ALIGN;
    remainingWidth = jawWidth;
    brushHeight = handleHeight + ALIGN2;

    jawPoints = outline(path([
        ["P", radius, radius],
        ["C", radius, 90, 270],
        ["L", remainingLength, radius - remainingWidth / 2],
        ["V", remainingWidth],
    ]), distance);

    difference() {
        cushion([handleLength, handleWidth, handleHeight], r=radius, center=true);
        translateZ(-brushHeight / 2) {
            simplePolyhedron(
                bottom = jawPoints,
                top = outline(jawPoints, brushHeight),
                distance = zAxis3D(brushHeight)
            );
        }
    }
}

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {

    // Draws the ready to print model
    barrierPegExtractor(
        width = barrierWidth,
        height = barrierHeight,
        diameter = fastenerDiameter,
        thickness = trackGroundThickness,
        distance = printTolerance
    );

}
