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
 * Defines the profiles for the full tiles.
 *
 * @author jsconan
 */

/**
 * Draws the profile of a tile fastening hole.
 *
 * To get the final shape, rotate_extrude(angle=360, convexity=10) must be applied.
 *
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the track ground.
 * @param Number diameter - The diameter of the fasteners.
 * @param Number headDiameter - The diameter of the fasteners head.
 * @param Number headHeight - The height of the fasteners head.
 * @param Number [distance] - An additional distance added to the outline of the shape.
 */
module tileHoleProfile(width, height, thickness, diameter, headDiameter, headHeight, distance=0) {
    // Prepare the parameters for the polygon
    fullHeight = height + thickness + ALIGN2;
    alignedHeight = height + ALIGN;
    alignedThickness = thickness + ALIGN;
    headRadius = max(headDiameter, diameter) / 2 + distance;
    radius = diameter / 2 + distance;
    pegRadius = getBarrierPegDiameter(width, height) / 2 + distance;
    pegHeight = getBarrierPegInnerHeight(width, height) + layerHeight + ALIGN;
    pegFootRadius = pegRadius + alignedThickness;
    remainingRadius = pegRadius - radius;
    remainingPegHeight = pegHeight - remainingRadius;
    remainingHeight = alignedHeight - headHeight - pegHeight;
    remainingWidth = headRadius - radius;

    // Uncomment to debug:
    // %translateY(height / 2) rectangle([headRadius * 2, height]);
    // %translateY(-thickness / 2) rectangle([pegFootRadius * 2, thickness]);

    // Draw the profile
    polygon(path([
        ["P", 0, alignedHeight],
        ["V", -fullHeight],
        ["H", pegFootRadius],
        ["L", -alignedThickness, alignedThickness],
        ["V", remainingPegHeight],
        ["L", -remainingRadius, remainingRadius],
        ["V", remainingHeight],
        ["H", remainingWidth],
        ["V", headHeight],
    ]), convexity = 10);
}
