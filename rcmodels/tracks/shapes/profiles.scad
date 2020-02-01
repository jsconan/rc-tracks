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
 * @param Number [distance] - An additional distance added to the outline.
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
 * @param Number base - The base value used to design the barrier link.
 * @param Number [distance] - The additional distance added to the outline.
 */
module barrierLinkProfile(base, distance = 0) {
    polygon(getBarrierLinkPoints(
        base = base,
        distance = distance
    ));
}

/**
 * Computes the points defining the profile of a barrier holder notch.
 * @param Number base - The base value used to design the barrier link.
 * @param Number strip - The height of the barrier body part that will be inserted in the holder.
 * @param Number indent - The indent of the barrier body strip.
 * @param Number [distance] - An additional distance added to the outline.
 * @returns Vector[]
 */
function getBarrierNotchPoints(base, strip, indent, distance = 0) =
    let(
        width = getBarrierNotchWidth(base, indent, distance),
        top = getBarrierNotchDistance(base, indent, distance),
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
 * @param Number [distance] - An additional distance added to the outline.
 */
module barrierNotchProfile(base, strip, indent, distance = 0) {
    polygon(getBarrierNotchPoints(
        base = base,
        strip = strip,
        indent = indent,
        distance = distance
    ));
}

/**
 * Computes the points defining the profile of a barrier holder.
 * @param Number base - The base value used to design the barrier link.
 * @param Number strip - The height of the barrier body part that will be inserted in the holder.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number [distance] - An additional distance added to the outline.
 * @returns Vector[]
 */
function getBarrierHolderPoints(base, strip, thickness, distance = 0) =
    let(
        linkWidth = getBarrierLinkWidth(base, distance),
        top = nozzleAligned((linkWidth - thickness) / 2) * 2 + thickness,
        width = getBarrierHolderWidth(base, distance),
        height = getBarrierHolderHeight(strip),
        lineW = (width - top) / 2,
        lineH = height - base
    )
    path([
        ["P", -width / 2, 0],
        ["V", base],
        ["L", lineW, lineH],
        ["H", top],
        ["L", lineW, -lineH],
        ["V", -base]
    ])
;

/**
 * Draws the profile of a barrier holder.
 * @param Number base - The base value used to design the barrier link.
 * @param Number strip - The height of the barrier body part that will be inserted in the holder.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number [distance] - An additional distance added to the outline.
 */
module barrierHolderProfile(base, strip, thickness, distance = 0) {
    polygon(getBarrierHolderPoints(
        base = base,
        strip = strip,
        thickness = thickness,
        distance = distance
    ));
}
