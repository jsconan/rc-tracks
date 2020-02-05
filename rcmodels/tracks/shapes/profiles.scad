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
 * @version 0.2.0
 */

/**
 * Computes the points defining the profile of a barrier link.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 * @returns Vector[]
 */
function getBarrierLinkPoints(base, distance = 0) =
    let(
        half = base / 2
    )
    outline(path([
        ["P", half, half],
        ["H", -base],
        ["C", [half, half], 0, 180],
        ["V", -base],
        ["C", [half, half], 180, 360],
        ["H", base],
    ]), distance)
;

/**
 * Draws the profile of a barrier link.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 */
module barrierLinkProfile(base, distance = 0) {
    polygon(getBarrierLinkPoints(
        base = base,
        distance = distance
    ));
}

/**
 * Computes the points defining the profile of a barrier holder notch.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 * @returns Vector[]
 */
function getBarrierNotchPoints(base, distance = 0) =
    let(
        width = getBarrierNotchWidth(base, distance),
        top = getBarrierNotchDistance(base, distance),
        strip = getBarrierStripHeight(base),
        indent = getBarrierStripIndent(base),
        height = strip - indent
    )
    path([
        ["P", -width / 2, 0],
        ["L", indent, height],
        ["H", top],
        ["L", indent, -height],
        ["V", -base],
        ["H", -width]
    ])
;

/**
 * Draws the profile of a barrier holder notch.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 */
module barrierNotchProfile(base, distance = 0) {
    polygon(getBarrierNotchPoints(
        base = base,
        distance = distance
    ));
}

/**
 * Computes the points defining the profile of a barrier holder.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 * @returns Vector[]
 */
function getBarrierHolderPoints(base, thickness) =
    let(
        linkWidth = getBarrierLinkWidth(base, printTolerance),
        top = getBarrierHolderTopWidth(base, thickness),
        width = getBarrierHolderWidth(base),
        height = getBarrierHolderHeight(base),
        offset = getBarrierHolderOffset(base),
        lineW = (width - top) / 2,
        lineH = height - base
    )
    path([
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
    ])
;

/**
 * Draws the profile of a barrier holder.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 */
module barrierHolderProfile(base, thickness) {
    polygon(getBarrierHolderPoints(
        base = base,
        thickness = thickness
    ));
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
            profile = outline(getBarrierHolderPoints(
                base = base,
                thickness = thickness
            ), -distance);

            polygon(outline(profile, -wall));
            polygon(profile);
        }
    }
}

/**
 * Draws the profile of a wire clip.
 * @param Number wall - The thickness of the outline.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 */
module wireClipProfile(wall, base, thickness) {
    holderWidth = getBarrierHolderWidth(base) + wall * 2;
    holderHeight = getBarrierHolderHeight(base);

    difference() {
        barrierHolderOutline(
            wall = wall,
            base = base,
            thickness = thickness,
            distance = 0
        );

        translateY(holderHeight) {
            rectangle([thickness, wall * 2]);
        }
    }
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
 * Draws the profile of an arch tower that will clamp a barrier border.
 * @param Number wall - The thickness of the outline.
 * @param Number height - The height of the barrier.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 */
module archTowerProfile(wall, height, base, thickness) {
    holderHeight = getBarrierHolderHeight(base) + wall + printTolerance;
    bodyHeight = getBarrierBodyInnerHeight(height, base);
    towerWidth = thickness + printTolerance + wall * 2;
    offset = holderHeight + bodyHeight / 2;

    difference() {
        union() {
            barrierHolderOutline(
                wall = wall,
                base = base,
                thickness = thickness,
                distance = printTolerance
            );
            translateY(offset) {
                rectangle([towerWidth, bodyHeight]);
            }
        }

        translateY(offset) {
            rectangle([thickness + printTolerance, bodyHeight + wall]);
        }
    }
}
