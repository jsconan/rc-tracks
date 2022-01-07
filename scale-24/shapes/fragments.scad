/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2020-2022 Jean-Sebastien CONAN
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
 * A race track system for 1/24 to 1/32 scale RC cars.
 *
 * Defines the fragments shapes for the track elements.
 *
 * @author jsconan
 */

/**
 * Draws the shape of a barrier link.
 * @param Number height - The height of the link.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 * @param Boolean [center] - The shape is centered vertically.
 */
module barrierLink(height, base, distance = 0, center = false) {
    linear_extrude(height=height, center=center, convexity=10) {
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
        linear_extrude(height=thickness, center=center, convexity=10) {
            barrierNotchProfile(
                base = base,
                distance = distance
            );
        }
    }
}

/**
 * Draws the negative shape of a barrier holder notch.
 * @param Number length - The length of the shape.
 * @param Number thickness - The thickness of the shape.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [notches] - The number of notches.
 */
module barrierNotchNegative(length, thickness, base, notches = 2) {
    height = getBarrierHolderHeight(base) * 2;
    notches = max(notches, 1);
    interval = length / notches;
    count = notches + 1;

    difference() {
        box([length + 2, thickness, height]);

        rotateX(90) {
            barrierNotch(
                thickness = thickness * 2,
                base = base,
                distance = printTolerance / 2,
                interval = interval,
                count = count,
                center = true
            );
        }
    }
}

/**
 * Carves the barrier notch in the child shape.
 * @param Number length - The length of the element.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [notches] - The number of notches.
 */
module carveBarrierNotch(length, thickness, base, notches = 2) {
    difference() {
        children();
        translateZ(minThickness) {
            barrierNotchNegative(
                length = length,
                thickness = thickness,
                base = base,
                notches = notches
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
 * @param Number [distance] - An additional distance added to the outline of the profile.
 * @param Boolean [center] - The shape is centered vertically.
 */
module clip(wall, height, base, thickness, distance = 0, center = false) {
    linear_extrude(height=height, center=center, convexity=10) {
        clipProfile(
            wall = wall,
            base = base,
            thickness = thickness,
            distance = distance
        );
    }
}
