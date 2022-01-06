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
    linkProfile(
        neck = [base / 2, base],
        bulb = base,
        distance = distance
    );
}

/**
 * Draws the profile of a barrier holder notch.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 */
module barrierNotchProfile(base, distance = 0) {
    width = getBarrierNotchWidth(base, distance);
    top = getBarrierNotchDistance(base, distance);
    indent = getBarrierStripIndent(base);
    height = getBarrierStripHeight(base) - indent;

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
 * Draws the outline of a barrier holder profile.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number holderOffset - The offset of the shape edges.
 * @param Number bottomWidth - The width of the bottom of the shape.
 * @param Number topWidth - The width of the top of the shape.
 * @returns Vector[]
 */
function getBarrierHolderProfilePoints(base, holderOffset, bottomWidth, topWidth) =
    let(
        holderHeight = getBarrierHolderHeight(base),
        holderSide = base - holderOffset,
        holderLineX = (bottomWidth - topWidth) / 2 - holderOffset,
        holderLineY = holderHeight - holderSide - holderOffset * 2
    )
    path([
        ["P", holderOffset - bottomWidth / 2, 0],
        ["L", -holderOffset, holderOffset],
        ["V", holderSide],
        ["L", holderLineX, holderLineY],
        ["L", holderOffset, holderOffset],
        ["H", topWidth],
        ["L", holderOffset, -holderOffset],
        ["L", holderLineX, -holderLineY],
        ["V", -holderSide],
        ["L", -holderOffset, -holderOffset]
    ])
;

/**
 * Draws the profile of a barrier holder.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module barrierHolderProfile(base, thickness, distance = 0) {
    polygon(outline(getBarrierHolderProfilePoints(
        base = base,
        holderOffset = base / 4,
        bottomWidth = getBarrierHolderWidth(base),
        topWidth = getBarrierHolderTopWidth(base, thickness)
    ), -distance), convexity = 10);
}

/**
 * Draws the profile of a unibody barrier.
 * @param Number height - The height of the barrier.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body for a barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module barrierUnibodyProfile(height, base, thickness, distance = 0) {
    holderTopWidth = getBarrierHolderTopWidth(base, thickness);
    holderWidth = getBarrierHolderWidth(base);
    holderHeight = getBarrierHolderHeight(base);
    holderOffset = base / 4;
    holderSide = base - holderOffset;
    holderOffsetWidth = holderWidth - holderOffset * 2;
    holderLineX = (holderWidth - holderTopWidth) / 2 - holderOffset;
    holderLineY = holderHeight - base - holderOffset;

    unibodyOffset = base / 2;
    unibodyNeck = base / 2;
    unibodySide = base - unibodyOffset;
    unibodyWidth = getBarrierUnibodyWidth(base);
    unibodyOffsetWidth = unibodyWidth - unibodyOffset * 2;
    unibodyLineX = (unibodyWidth - holderTopWidth) / 2 - unibodyOffset;
    unibodyLineY = height - holderHeight - unibodyNeck - base - unibodyOffset;

    startX = holderTopWidth / 2;
    startY = holderSide + unibodyLineY + unibodyOffset + unibodyNeck + holderOffset;

    polygon(outline(path([
        ["P", -startX, startY],
        // barrier holder profile
        ["L", -holderOffset, holderOffset],
        ["L", -holderLineX, holderLineY],
        ["V", holderSide],
        ["L", holderOffset, holderOffset],
        ["H", holderOffsetWidth],
        ["L", holderOffset, -holderOffset],
        ["V", -holderSide],
        ["L", -holderLineX, -holderLineY],
        ["L", -holderOffset, -holderOffset],
        // unibody profile
        ["V", -unibodyNeck],
        ["L", unibodyOffset, -unibodyOffset],
        ["L", unibodyLineX, -unibodyLineY],
        ["V", -unibodySide],
        ["L", -unibodyOffset, -unibodyOffset],
        ["H", -unibodyOffsetWidth],
        ["L", -unibodyOffset, unibodyOffset],
        ["V", unibodySide],
        ["L", unibodyLineX, unibodyLineY],
        ["L", unibodyOffset, unibodyOffset],
        ["V", unibodyNeck]
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
        translateY(distance) {
            barrierHolderOutline(
                wall = wall,
                base = base,
                thickness = thickness,
                distance = distance
            );
        }
        translateY(holderHeight + wall * 1.5 + distance * 2) {
            rectangle([getBarrierHolderTopWidth(base, thickness), wall * 2] + vector2D(distance));
        }
    }
}
