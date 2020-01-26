
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
 * Defines some profile shapes.
 *
 * @author jsconan
 * @version 0.1.0
 */

/**
 * Computes the points defining the profile of the bottom border mount.
 * @param Number slotWidth - The width of the slot that will hold the border sheet.
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number edge - The width of each edge of the border mount.
 * @returns Vector[]
 */
function getBorderBottomPoints(slotWidth, slotDepth, edge) =
    let(
        width = edge * 4 + slotWidth
    )
    path([
        ["P", -width / 2, 0],
        ["V", edge],
        ["L", edge, slotDepth],
        ["H", edge],
        ["V", -slotDepth],
        ["H", slotWidth],
        ["V", slotDepth],
        ["H", edge],
        ["L", edge, -slotDepth],
        ["V", -edge]
    ])
;

/**
 * Computes the points defining the profile of the top border mount.
 * @param Number slotWidth - The width of the slot that will hold the border sheet.
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number edge - The width of each edge of the border mount.
 * @returns Vector[]
 */
function getBorderTopPoints(slotWidth, slotDepth, edge) =
    let(
        width = edge * 2 + slotWidth,
        height = edge + slotDepth
    )
    path([
        ["P", -width / 2, 0],
        ["V", height],
        ["H", edge],
        ["V", -slotDepth],
        ["H", slotWidth],
        ["V", slotDepth],
        ["H", edge],
        ["V", -height]
    ])
;

/**
 * Computes the points defining the profile of a border mount notch.
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number edge - The width of each edge of the notch.
 * @param Number [direction] - The direction of the shape (1: right, -1: left)
 * @param Boolean [negative] - The shape will be used in a difference operation
 * @returns Vector[]
 */
function getBorderNotchPoints(slotDepth, edge, direction=1, negative=false) =
    let(
        start = negative ? 1 : 0,
        direction = direction >= 0 ? 1 : -1,
        width = edge * 2
    )
    path([
        ["P", direction * -start, slotDepth],
        ["H", direction * (edge + start)],
        ["L", direction * edge, -slotDepth],
        ["V", -start],
        ["H", direction * -(width + start)]
    ])
;

/**
 * Draws the profile of the bottom border mount.
 * @param Number slotWidth - The width of the slot that will hold the border sheet.
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number edge - The width of each edge of the border mount.
 */
module borderBottomProfile(slotWidth, slotDepth, edge) {
    polygon(getBorderBottomPoints(
        slotWidth = slotWidth,
        slotDepth = slotDepth,
        edge = edge
    ));
}

/**
 * Draws the profile of the top border mount.
 * @param Number slotWidth - The width of the slot that will hold the border sheet.
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number edge - The width of each edge of the border mount.
 */
module borderTopProfile(slotWidth, slotDepth, edge) {
    polygon(getBorderTopPoints(
        slotWidth = slotWidth,
        slotDepth = slotDepth,
        edge = edge
    ));
}

/**
 * Draws the profile of a border mount notch.
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number edge - The width of each edge of the notch.
 * @param Number [direction] - The direction of the shape (1: right, -1: left)
 * @param Boolean [negative] - The shape will be used in a difference operation
 */
module borderNotchProfile(slotDepth, edge, direction=1, negative=false) {
    polygon(getBorderNotchPoints(
        slotDepth = slotDepth,
        edge = edge,
        direction = direction,
        negative = negative
    ));
}

/**
 * Draws the profile of a set of border mount notches.
 * @param Number length - The length of the set
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number edge - The width of each edge of the notch.
 * @param Boolean [negative] - The shape will be used in a difference operation
 */
module borderNotchesProfile(length, slotDepth, edge, negative=false) {
    borderNotchProfile(
        slotDepth = slotDepth,
        edge = edge,
        direction = 1,
        negative = negative
    );
    translateX(length) {
        borderNotchProfile(
            slotDepth = slotDepth,
            edge = edge,
            direction = -1,
            negative = negative
        );
    }
}
