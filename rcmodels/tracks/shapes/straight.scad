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
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
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
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number ratio - The ratio to apply on the length
 */
module straightBarrierHolder(length, thickness, base, ratio = 1) {
    linkHeight = getBarrierHolderHeight(base) - base;
    thickness = thickness + printTolerance;
    length = length * ratio;
    notches = ratio * 2;
    interval = length / notches;
    count = notches + 1;

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
                        interval = interval,
                        count = count,
                        center = true
                    );
                }
            }
        }
    }
}

/**
 * Draws the shape of an arch tower that will clamp a barrier border.
 * @param Number wall - The thickness of the outline.
 * @param Number length - The length of a track element.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number right - Is it the right or the left part of the track element that is added to the tower?
 */
module archTower(wall, length, base, thickness, right = false) {
    holderHeight = getBarrierHolderHeight(base);
    indent = getBarrierStripIndent(base);

    rotateZ(-90) {
        difference() {
            clip(
                wall = wall,
                height = holderHeight,
                base = base,
                thickness = thickness
            );

            translate([0, wall / 2, holderHeight - indent]) {
                box([thickness, wall * 2, indent * 2]);
            }
        }
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
