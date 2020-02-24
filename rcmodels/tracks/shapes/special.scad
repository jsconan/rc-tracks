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
 * Defines some special track parts.
 *
 * @author jsconan
 */

/**
 * Draws the shape of an arch tower that will clamp a barrier border.
 * @param Number length - The length of a track element.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number wall - The thickness of the outline.
 * @param Number right - Is it the right or the left part of the track element that is added to the tower?
 */
module archTower(length, thickness, base, wall, right = false) {
    holderHeight = getBarrierHolderHeight(base);
    indent = getBarrierStripIndent(base);

    rotateZ(-90) {
        difference() {
            clip(
                wall = wall,
                height = holderHeight,
                base = base,
                thickness = thickness + printTolerance,
                distance = printTolerance
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
