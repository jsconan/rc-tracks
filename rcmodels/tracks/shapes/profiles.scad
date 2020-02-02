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
 * @param Number base - The base value used to design the barrier link.
 * @param Number [tolerance] - An additional distance added to the outline of the barrier link.
 * @returns Vector[]
 */
function getBarrierLinkPoints(base, tolerance = 0) =
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
    ]), tolerance)
;

/**
 * Draws the profile of a barrier link.
 * @param Number base - The base value used to design the barrier link.
 * @param Number [tolerance] - An additional distance added to the outline of the barrier link.
 */
module barrierLinkProfile(base, tolerance = 0) {
    polygon(getBarrierLinkPoints(
        base = base,
        tolerance = tolerance
    ));
}

/**
 * Computes the points defining the profile of a barrier holder notch.
 * @param Number base - The base value used to design the barrier link.
 * @param Number strip - The height of the barrier body part that will be inserted in the holder.
 * @param Number indent - The indent of the barrier body strip.
 * @param Number [tolerance] - An additional distance added to the outline of the barrier link.
 * @returns Vector[]
 */
function getBarrierNotchPoints(base, strip, indent, tolerance = 0) =
    let(
        width = getBarrierNotchWidth(base, indent, tolerance),
        top = getBarrierNotchDistance(base, indent, tolerance),
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
 * @param Number base - The base value used to design the barrier link.
 * @param Number strip - The height of the barrier body part that will be inserted in the holder.
 * @param Number indent - The indent of the barrier body strip.
 * @param Number [tolerance] - An additional distance added to the outline of the barrier link.
 */
module barrierNotchProfile(base, strip, indent, tolerance = 0) {
    polygon(getBarrierNotchPoints(
        base = base,
        strip = strip,
        indent = indent,
        tolerance = tolerance
    ));
}

/**
 * Computes the points defining the profile of a barrier holder.
 * @param Number base - The base value used to design the barrier link.
 * @param Number strip - The height of the barrier body part that will be inserted in the holder.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number [tolerance] - An additional distance added to the outline of the barrier link.
 * @returns Vector[]
 */
function getBarrierHolderPoints(base, strip, thickness, tolerance = 0) =
    let(
        linkWidth = getBarrierLinkWidth(base, tolerance),
        top = nozzleAligned((linkWidth - thickness) / 2) * 2 + thickness,
        width = getBarrierHolderWidth(base, tolerance),
        height = getBarrierHolderHeight(strip),
        lineW = (width - top) / 2,
        lineH = height - base,
        offset = printResolution * 2
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
 * @param Number base - The base value used to design the barrier link.
 * @param Number strip - The height of the barrier body part that will be inserted in the holder.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number [tolerance] - An additional distance added to the outline of the barrier link.
 */
module barrierHolderProfile(base, strip, thickness, tolerance = 0) {
    polygon(getBarrierHolderPoints(
        base = base,
        strip = strip,
        thickness = thickness,
        tolerance = tolerance
    ));
}

/**
 * Draws the outline of a barrier holder.
 * @param Number wall - The thickness of the outline.
 * @param Number base - The base value used to design the barrier link.
 * @param Number strip - The height of the barrier body part that will be inserted in the holder.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number [tolerance] - An additional distance added to the outline of the barrier link.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module barrierHolderOutline(wall, base, strip, thickness, tolerance = 0, distance = 0) {
    translateY(wall) {
        difference() {
            profile = outline(getBarrierHolderPoints(
                base = base,
                strip = strip,
                thickness = thickness,
                tolerance = tolerance
            ), -distance);

            polygon(outline(profile, -wall));
            polygon(profile);
        }
    }
}

/**
 * Draws the profile of a wire clip.
 * @param Number wall - The thickness of the outline.
 * @param Number base - The base value used to design the barrier link.
 * @param Number strip - The height of the barrier body part that will be inserted in the holder.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number [tolerance] - An additional distance added to the outline of the barrier link.
 */
module wireClipProfile(wall, base, strip, thickness, tolerance = 0) {
    holderWidth = getBarrierHolderWidth(base, tolerance) + wall * 2;
    holderHeight = getBarrierHolderHeight(strip);

    difference() {
        barrierHolderOutline(
            wall = wall,
            base = base,
            strip = strip,
            thickness = thickness,
            tolerance = tolerance,
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
 * @param Number base - The base value used to design the barrier link.
 * @param Number strip - The height of the barrier body part that will be inserted in the holder.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number [tolerance] - An additional distance added to the outline of the barrier link.
 */
module archTowerProfile(wall, height, base, strip, thickness, tolerance = 0) {
    holderHeight = getBarrierHolderHeight(strip) + wall + tolerance;
    bodyHeight = getBarrierBodyInnerHeight(height, strip);
    towerWidth = thickness + tolerance + wall * 2;
    offset = holderHeight + bodyHeight / 2;

    difference() {
        union() {
            barrierHolderOutline(
                wall = wall,
                base = base,
                strip = strip,
                thickness = thickness,
                tolerance = tolerance,
                distance = tolerance
            );
            translateY(offset) {
                rectangle([towerWidth, bodyHeight]);
            }
        }

        translateY(offset) {
            rectangle([thickness + tolerance, bodyHeight + wall]);
        }
    }
}
