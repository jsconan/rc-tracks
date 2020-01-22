
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
 * A 1/24 RC track system.
 *
 * Defines some shared shapes.
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
function getBorderBottomProfile(slotWidth, slotDepth, edge) =
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
function getBorderTopProfile(slotWidth, slotDepth, edge) =
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
 * Draws the shape of a the bottom border mount.
 * @param Number slotWidth - The width of the slot that will hold the border sheet.
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number edge - The width of each edge of the border mount.
 */
module drawBorderBottomShape(slotWidth, slotDepth, edge) {
    polygon(getBorderBottomProfile(
        slotWidth = slotWidth,
        slotDepth = slotDepth,
        edge = edge
    ));
}

/**
 * Draws the shape of a the top border mount.
 * @param Number slotWidth - The width of the slot that will hold the border sheet.
 * @param Number slotDepth - The depth of the slot that will hold the border sheet.
 * @param Number edge - The width of each edge of the border mount.
 */
module drawBorderTopShape(slotWidth, slotDepth, edge) {
    polygon(getBorderTopProfile(
        slotWidth = slotWidth,
        slotDepth = slotDepth,
        edge = edge
    ));
}
