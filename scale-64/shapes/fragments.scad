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
 * Defines the fragments shapes for the track elements.
 *
 * @author jsconan
 */

/**
 * Draws the shape of a barrier link.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number [distance] - An additional distance added to the outline of the shape.
 * @param Boolean [center] - The shape is centered vertically.
 */
module barrierLink(width, height, distance = 0, center = false) {
    linear_extrude(height=height, center=center, convexity=10) {
        barrierLinkProfile(
            width = width,
            height = height,
            distance = distance
        );
    }
}

/**
 * Draws the shape of a barrier fastening hole.
 * @param Number height - The height of the barrier.
 * @param Number diameter - The diameter of the fasteners.
 * @param Number headDiameter - The diameter of the fasteners head.
 * @param Number headHeight - The height of the fasteners head.
 * @param Number [distance] - An additional distance added to the outline of the shape.
 */
module barrierFastenerHole(height, diameter, headDiameter, headHeight, distance = 0) {
    rotate_extrude(angle=360, convexity=10) {
        barrierFastenerHoleProfile(
            height = height,
            diameter = diameter,
            headDiameter = headDiameter,
            headHeight = headHeight,
            distance = distance
        );
    }
}