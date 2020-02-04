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
 * Defines the straight track parts.
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
 * Draws the shape of a barrier body.
 * @param Number length - The length of the track element.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [notches] - The number of notches.
 */
module barrierBody(length, height, thickness, base, notches = 1) {
    count = notches + 1;
    interval = length / notches;

    difference() {
        box(
            size = [length, height, thickness],
            center = true
        );

        repeatMirror(interval=[0, height, 0], axis=[0, 1, 0], center=true) {
            barrierNotch(
                thickness = thickness * 2,
                base = base,
                distance = printTolerance,
                interval = interval,
                count = count,
                center = true
            );
        }
    }
}

/**
 * Draws the main shape of a barrier holder for a straight track element.
 * @param Number length - The length of the element.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 */
module straightBarrierMain(length, thickness, base) {
    linkHeight = getBarrierHolderHeight(base) - base;

    translateX(-length / 2) {
        barrierLink(
            height = linkHeight - printResolution,
            base = base
        );
    }
    difference() {
        rotate([90, 0, 90]) {
            negativeExtrude(height=length, center=true) {
                barrierHolderProfile(
                    base = base,
                    thickness = thickness
                );
            }
        }
        translate([length / 2, 0, -1]) {
            barrierLink(
                height = linkHeight + printResolution + 1,
                base = base,
                distance = printTolerance
            );
        }
    }
}

/**
 * Draws the barrier holder for a straight track element.
 * @param Number length - The length of the element.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 */
module straightBarrierHolder(length, thickness, base) {
    linkHeight = getBarrierHolderHeight(base) - base;
    thickness = thickness + printTolerance;

    difference() {
        straightBarrierMain(
            length = length,
            thickness = thickness,
            base = base
        );
        translateZ(minThickness) {
            difference() {
                box([length + 2, thickness, linkHeight * 2]);

                rotateX(90) {
                    barrierNotch(
                        thickness = thickness * 2,
                        base = base,
                        distance = printTolerance / 2,
                        interval = length / 2,
                        count = 3,
                        center = true
                    );
                }
            }
        }
    }
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

/**
 * Draws the shape of an arch tower that will clamp a barrier border.
 * @param Number wall - The thickness of the outline.
 * @param Number height - The height of the barrier.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 * @param Boolean [center] - The shape is centered vertically.
 */
module archTower(wall, height, base, thickness, center = false) {
    holderHeight = getBarrierHolderHeight(base);

    negativeExtrude(height=holderHeight, center=center) {
        archTowerProfile(
            wall = wall,
            height = height,
            base = base,
            thickness = thickness
        );
    }
}

/**
 * Draws the shape of an arch tower with the barrier holders.
 * @param Number wall - The thickness of the outline.
 * @param Number height - The length of a track element.
 * @param Number height - The height of the barrier.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number right - Is it the right or the left part of the track element that is added to the tower?
 */
module archTowerWidthHolder(wall, length, height, base, thickness, right = false) {
    rotateZ(-90) {
        archTower(
            wall = wall,
            height = height,
            base = base,
            thickness = thickness
        );
    }
    difference() {
        rotateZ(right ? 180 : 0) {
            straightBarrierHolder(
                length = length,
                thickness = thickness,
                base = base
            );
        }
        translate([length, 0, -length] / 2) {
            box(length);
        }
    }
}
