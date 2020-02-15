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
 * Defines the profile shapes for the track elements.
 *
 * @author jsconan
 */

/**
 * Draws the profile of a barrier link.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module barrierLinkProfile(base, distance = 0) {
    half = base / 2;

    polygon(outline(path([
        ["P", half, half],
        ["H", -base],
        ["C", [half, half], 0, 180],
        ["V", -base],
        ["C", [half, half], 180, 360],
        ["H", base],
    ]), distance), convexity = 10);
}

/**
 * Draws the profile of a barrier holder notch.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 */
module barrierNotchProfile(base, distance = 0) {
    width = getBarrierNotchWidth(base, distance);
    top = getBarrierNotchDistance(base, distance);
    strip = getBarrierStripHeight(base);
    indent = getBarrierStripIndent(base);
    height = strip - indent;

    polygon(path([
        ["P", -width / 2, 0],
        ["L", indent, height],
        ["H", top],
        ["L", indent, -height],
        ["V", -base],
        ["H", -width]
    ]), convexity = 10);
}

/**
 * Draws the profile of a barrier holder.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module barrierHolderProfile(base, thickness, distance = 0) {
    linkWidth = getBarrierLinkWidth(base, printTolerance);
    top = getBarrierHolderTopWidth(base, thickness);
    width = getBarrierHolderWidth(base);
    height = getBarrierHolderHeight(base);
    offset = base / 4;
    lineW = (width - top) / 2;
    lineH = height - base;

    polygon(outline(path([
        ["P", -width / 2 + offset, 0],
        ["L", -offset, offset],
        ["V", base - offset],
        ["L", lineW - offset, lineH - offset],
        ["L", offset, offset],
        ["H", top],
        ["L", offset, -offset],
        ["L", lineW - offset, -lineH + offset],
        ["V", -base + offset],
        ["L", -offset, -offset]
    ]), -distance), convexity = 10);
}

/**
 * Draws the outline of a barrier holder.
 * @param Number wall - The thickness of the outline.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module barrierHolderOutline(wall, base, thickness, distance = 0) {
    translateY(wall) {
        difference() {
            barrierHolderProfile(
                base = base,
                thickness = thickness,
                distance = wall + distance
            );

            barrierHolderProfile(
                base = base,
                thickness = thickness,
                distance = distance
            );
        }
    }
}

/**
 * Draws the profile of a clip for a barrier holder.
 * @param Number wall - The thickness of the outline.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module clipProfile(wall, base, thickness, distance = 0) {
    holderHeight = getBarrierHolderHeight(base);

    difference() {
        barrierHolderOutline(
            wall = wall,
            base = base,
            thickness = thickness,
            distance = distance
        );

        translateY(holderHeight + wall * 1.5 + distance) {
            rectangle([getBarrierHolderTopWidth(base, thickness), wall * 2] + vector2D(distance));
        }
    }
}
