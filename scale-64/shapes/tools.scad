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
 * Defines the shapes for the track tools.
 *
 * @author jsconan
 */

/**
 * Draws the shape of a barrier peg remover.
 * @param Number diameter - The diameter of the fastener.
 * @param Number headDiameter - The diameter of the fastener head.
 * @param Number headHeight - The height of the fastener head.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module barrierPegRemover(diameter, headDiameter, headHeight, distance=0) {
    rotate_extrude(angle=DEGREES, convexity=10) {
        barrierPegRemoverProfile(
            diameter = diameter,
            headDiameter = headDiameter,
            headHeight = headHeight,
            distance = distance
        );
    }
}

/**
 * Draws the shape of the handle of a barrier peg extractor.
 *
 * To get the final shape, linear_extrude(height=height, convexity=10) must be applied.
 *
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
