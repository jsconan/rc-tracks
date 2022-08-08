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
 * Ready to print track tool: a barrier peg remover.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

/**
 * Draws the profile of the barrier peg remover.
 *
 * To get the final shape, rotate_extrude(angle=360, convexity=10) must be applied.
 *
 * @param Number diameter - The diameter of the fastener.
 * @param Number headDiameter - The diameter of the fastener head.
 * @param Number headHeight - The height of the fastener head.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module barrierPegRemoverProfile(diameter, headDiameter, headHeight, distance=0) {
    // Uncomment to debug:
    // %rectangle([width, height]);

    // Prepare the parameters for the polygon
    headRadius = max(headDiameter, diameter) / 2 + distance;
    holeRadius = diameter / 2 + distance;
    radius = headRadius * 2;
    pocket = diameter / 4;
    height = headRadius * 4;

    remainingRadius = radius - holeRadius;
    remainingTopRadius = radius - headRadius;
    remainingHeadRadius = headRadius - holeRadius;
    remainingHeight = height - headHeight - pocket * 3;

    // Draw the profile
    polygon(path([
        ["P", holeRadius, -height / 2],
        ["H", remainingRadius],
        ["V", pocket],
        ["L", -pocket, pocket],
        ["V", remainingHeight],
        ["L", pocket, pocket],
        ["V", headHeight],
        ["H", -remainingTopRadius],
        ["V", -headHeight],
        ["H", -remainingHeadRadius],
    ]), convexity = 10);
}

/**
 * Draws the shape of the barrier peg remover.
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

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {

    // Draws the ready to print model
    barrierPegRemover(
        diameter = fastenerDiameter,
        headDiameter = fastenerHeadDiameter,
        headHeight = fastenerHeadHeight,
        distance = 0
    );

}
