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
 * Defines the shapes for the track  accessories.
 *
 * @author jsconan
 * @version 0.2.0
 */

/**
 * Draws the profile of a wire clip.
 * @param Number wall - The thickness of the outline.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 */
module wireClipProfile(wall, base, thickness) {
    holderWidth = getBarrierHolderWidth(base) + wall * 2;

    clipProfile(
        wall = wall,
        base = base,
        thickness = thickness
    );
    repeat(intervalX = holderWidth - wall, center = true) {
        translateY(base / 2) {
            rectangle([wall, base]);
        }
    }
    ringSegment(
        r = [1, 1] * (holderWidth / 2),
        w = wall,
        a = -180,
        $fn = 10
    );
}

/**
 * Draws the shape of a wire clip.
 * @param Number wall - The thickness of the wire clip lines.
 * @param Number height - The thickness of the clip.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 * @param Boolean [center] - The shape is centered vertically.
 */
module wireClip(wall, height, base, thickness, center = false) {
    negativeExtrude(height=height, center=center) {
        wireClipProfile(
            wall = wall,
            base = base,
            thickness = thickness
        );
    }
}
