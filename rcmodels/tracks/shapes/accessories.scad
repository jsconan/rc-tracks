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
 */

/**
 * Draws the shape of a cable clip.
 * @param Number height - The thickness of the clip.
 * @param Number wall - The thickness of the cable clip lines.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 * @param Boolean [center] - The shape is centered vertically.
 */
module cableClip(height, wall, base, thickness, center = false) {
    holderWidth = getBarrierHolderWidth(base) + wall * 2;

    negativeExtrude(height=height, center=center) {
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
}

/**
 * Draws the shape of an accessory mast.
 * @param Number width - The width of the mast.
 * @param Number height - The height of the mast.
 * @param Number [distance] - An additional distance added to the outline.
 * @param Boolean [center] - The shape is centered vertically.
 */
module mast(width, height, distance = 0, center = false) {
    radius = getMastRadius(width);

    negativeExtrude(height=height, center=center) {
        rotateZ(getPolygonAngle(1, mastFacets) / 2) {
            polygon(
                points = outline(drawEllipse(r=radius, $fn=mastFacets), distance),
                convexity = 10
            );
        }
    }
}

/**
 * Draws the shape of rings that will maintain an accessory onto a mast.
 * @param Number width - The width of the mast.
 * @param Number height - The height of the ring.
 * @param Number wall - The thickness of the accessory ring.
 * @param Number [interval] - The interval between 2 rings.
 * @param Number [count] - The number of rings.
 * @param Number [distance] - An additional distance added to the outline.
 * @param Boolean [center] - The shape is centered.
 */
module mastRings(width, height, wall, interval = 0, count = 1, distance = 0, center = false) {
    repeat(count=count, intervalX=interval, center=center) {
        rotateY(90) {
            difference() {
                mast(
                    width = width,
                    height = height,
                    distance = wall + distance,
                    center = center
                );
                mast(
                    width = width,
                    height = height * 2 + 1,
                    distance = distance,
                    center = true
                );
            }
        }
    }
}

/**
 * Draws the shape of an accessory mast with a clip.
 * @param Number width - The width of the mast.
 * @param Number height - The height of the mast.
 * @param Number wall - The thickness of the accessory clip lines.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 */
module accessoryMast(width, height, wall, base, thickness) {
    rotateY(90) {
        mast(
            width = width,
            height = height,
            distance = 0,
            center = false
        );
    }
    rotateZ(90) {
        clip(
            wall = wall,
            height = width,
            base = base,
            thickness = thickness,
            center = true
        );
    }
}

/**
 * Draws the shape of an accessory flag.
 * @param Number width - The width of the flag.
 * @param Number height - The height of the flag.
 * @param Number thickness - The thickness of the flag.
 * @param Number ring - The width of the rings.
 * @param Number mast - The width of the mast.
 */
module accessoryFlag(width, height, thickness, ring, mast) {
    distance = printResolution;
    ringHeight = height / 4;
    ringInterval = height - ringHeight;
    ringOffset = apothem(n=mastFacets, r=getMastRadius(mast)) + distance + thickness;

    translateZ(ringOffset) {
        mastRings(
            width = mast,
            height = ringHeight,
            wall = thickness,
            interval = ringInterval,
            count = 2,
            distance = distance,
            center = true
        );
    }
    translateY(width / 2) {
        box([height, width, thickness]);
    }
}
