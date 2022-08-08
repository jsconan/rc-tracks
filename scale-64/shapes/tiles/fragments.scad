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
 * Defines the fragments for the full tiles.
 *
 * @author jsconan
 */

/**
 * Draws the shape of a tile link.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the track ground.
 * @param Number [distance] - An additional distance added to the outline of the shape.
 * @param Number [neckDistance] - An additional distance added to the neck of the link.
 */
module tileLink(width, height, thickness, distance=0, neckDistance=0) {
    translateZ(-thickness) {
        linear_extrude(height=height + thickness, center=false, convexity=10) {
            barrierLinkProfile(
                width = width,
                height = height,
                distance = distance,
                neckDistance = neckDistance
            );
        }
    }
}

/**
 * Draws the shape of a tile fastening hole.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the track ground.
 * @param Number diameter - The diameter of the fasteners.
 * @param Number headDiameter - The diameter of the fasteners head.
 * @param Number headHeight - The height of the fasteners head.
 * @param Number [distance] - An additional distance added to the outline of the shape.
 */
module tileHole(width, height, thickness, diameter, headDiameter, headHeight, distance=0) {
    rotate_extrude(angle=DEGREES, convexity=10) {
        tileHoleProfile(
            width = width,
            height = height,
            thickness = thickness,
            diameter = diameter,
            headDiameter = headDiameter,
            headHeight = headHeight,
            distance = distance
        );
    }
}
