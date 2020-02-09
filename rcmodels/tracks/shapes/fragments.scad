/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2020 Jean-Sebastien CONAN
 *
 * This file is part of jsconan/things.
 *
 * jsconan/things is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * jsconan/things is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with jsconan/things. If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * A race track system for 1/24 to 1/32 scale RC cars.
 *
 * Defines the fragments shapes for the track elements.
 *
 * @author jsconan
 * @version 0.2.0
 */

/**
 * Draws the shape of a barrier link.
 * @param Number height - The height of the link.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 * @param Boolean [center] - The shape is centered vertically.
 */
module barrierLink(height, base, distance = 0, center = false) {
    negativeExtrude(height=height, center=center) {
        barrierLinkProfile(
            base = base,
            distance = distance
        );
    }
}

/**
 * Draws the shape of a barrier holder notch.
 * @param Number thickness - The thickness of the shape.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 * @param Number [interval] - The distance between two notches.
 * @param Number [count] - The number of notches.
 * @param Boolean [center] - The shape is centered vertically.
 */
module barrierNotch(thickness, base, distance = 0, interval = 0, count = 1, center = false) {
    repeat(count=count, interval=[interval, 0, 0], center=true) {
        negativeExtrude(height=thickness, center=center) {
            barrierNotchProfile(
                base = base,
                distance = distance
            );
        }
    }
}

/**
 * Draws the shape of a clip.
 * @param Number wall - The thickness of the clip lines.
 * @param Number height - The thickness of the clip.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 * @param Boolean [center] - The shape is centered vertically.
 */
module clip(wall, height, base, thickness, center = false) {
    negativeExtrude(height=height, center=center) {
        clipProfile(
            wall = wall,
            base = base,
            thickness = thickness
        );
    }
}
