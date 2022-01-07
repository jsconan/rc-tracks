
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
 * Computes the points defining the profile of the barrier holder.
 * @param Number slotWidth - The width of the slot that will hold the barrier body.
 * @param Number slotDepth - The depth of the slot that will hold the barrier body.
 * @param Number base - The base value used to design the barrier holder.
 * @returns Vector[]
 */
function getBarrierHolderPoints(slotWidth, slotDepth, base) =
    let(
        width = base * 4 + slotWidth
    )
    path([
        ["P", -width / 2, 0],
        ["V", base],
        ["L", base, slotDepth],
        ["H", base],
        ["V", -slotDepth],
        ["H", slotWidth],
        ["V", slotDepth],
        ["H", base],
        ["L", base, -slotDepth],
        ["V", -base]
    ])
;

/**
 * Computes the points defining the profile of a barrier holder notch.
 * @param Number slotDepth - The depth of the slot that will hold the barrier body.
 * @param Number base - The base value used to design the barrier notches.
 * @param Number [direction] - The direction of the shape (1: right, -1: left)
 * @param Boolean [negative] - The shape will be used in a difference operation
 * @returns Vector[]
 */
function getBarrierNotchPoints(slotDepth, base, direction=1, negative=false) =
    let(
        start = negative ? 1 : 0,
        direction = direction >= 0 ? 1 : -1,
        width = base * 2
    )
    path([
        ["P", direction * -start, slotDepth],
        ["H", direction * (base + start)],
        ["L", direction * base, -slotDepth],
        ["V", -start],
        ["H", direction * -(width + start)]
    ])
;

/**
 * Draws the profile of the barrier holder.
 * @param Number slotWidth - The width of the slot that will hold the barrier body.
 * @param Number slotDepth - The depth of the slot that will hold the barrier body.
 * @param Number base - The base value used to design the barrier holder.
 */
module barrierHolderProfile(slotWidth, slotDepth, base) {
    polygon(getBarrierHolderPoints(
        slotWidth = slotWidth,
        slotDepth = slotDepth,
        base = base
    ));
}

/**
 * Draws the profile of a barrier holder notch.
 * @param Number slotDepth - The depth of the slot that will hold the barrier body.
 * @param Number base - The base value used to design the barrier notches.
 * @param Number [direction] - The direction of the shape (1: right, -1: left)
 * @param Boolean [negative] - The shape will be used in a difference operation
 */
module barrierNotchProfile(slotDepth, base, direction=1, negative=false) {
    polygon(getBarrierNotchPoints(
        slotDepth = slotDepth,
        base = base,
        direction = direction,
        negative = negative
    ));
}

/**
 * Draws the profile of a set of barrier holder notches.
 * @param Number length - The length of the set
 * @param Number slotDepth - The depth of the slot that will hold the barrier body.
 * @param Number base - The base value used to design the barrier notches.
 * @param Boolean [negative] - The shape will be used in a difference operation
 */
module barrierNotchesProfile(length, slotDepth, base, negative=false) {
    barrierNotchProfile(
        slotDepth = slotDepth,
        base = base,
        direction = 1,
        negative = negative
    );
    translateX(length) {
        barrierNotchProfile(
            slotDepth = slotDepth,
            base = base,
            direction = -1,
            negative = negative
        );
    }
}
