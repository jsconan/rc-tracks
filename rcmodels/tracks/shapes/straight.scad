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
 * Defines some straight track parts.
 *
 * @author jsconan
 * @version 0.1.0
 */

/**
 * Draws the shape of a barrier holder hook.
 * @param Number base - The width of each base of the hook.
 * @param Number thickness - The thickness of the hook
 * @param Boolean [negative] - The shape will be used in a difference operation
 */
module barrierHook(base, thickness, negative=false) {
    start = negative ? 1 : 0;
    base = nozzleAligned(base / 2) * 2;
    translateZ(-start) {
        box([base * 2, base, thickness + start]);
        translateX(-base) {
            slot([base, base * 2, thickness + start]);
        }
    }
}

/**
 * Draws the shape of barrier holder notch.
 * @param Number thickness - The thickness of the shape
 * @param Number slotDepth - The depth of the slot that will hold the barrier body.
 * @param Number base - The base value used to design the barrier notches.
 * @param Number [direction] - The direction of the shape (1: right, -1: left)
 * @param Boolean [negative] - The shape will be used in a difference operation
 * @param Boolean [center] - The shape is centered vertically
 */
module barrierNotch(thickness, slotDepth, base, direction=1, negative=false, center=false) {
    negativeExtrude(height=thickness, center=center) {
        barrierNotchProfile(
            slotDepth = slotDepth,
            base = base,
            direction = direction,
            negative = negative
        );
    }
}

/**
 * Draws the shape of barrier holder notches.
 * @param Number length - The length of the chunk
 * @param Number thickness - The thickness of the shape
 * @param Number slotDepth - The depth of the slot that will hold the barrier body.
 * @param Number base - The base value used to design the barrier notches.
 * @param Boolean [negative] - The shape will be used in a difference operation
 * @param Boolean [center] - The shape is centered vertically
 */
module barrierNotches(length, thickness, slotDepth, base, negative=false, center=false) {
    negativeExtrude(height=thickness, center=center) {
        barrierNotchesProfile(
            length = length,
            slotDepth = slotDepth,
            base = base,
            negative = negative
        );
    }
}

/**
 * Draws the shape of barrier holder notches for a full chunk.
 * @param Number length - The length of the chunk
 * @param Number thickness - The thickness of the shape
 * @param Number slotDepth - The depth of the slot that will hold the barrier body.
 * @param Number base - The base value used to design the barrier notches.
 * @param Boolean [negative] - The shape will be used in a difference operation
 * @param Boolean [center] - The shape is centered vertically
 */
module barrierNotchesFull(length, thickness, slotDepth, base, negative=false, center=false) {
    repeatMirror() {
        barrierNotches(
            length = length / 2,
            thickness = thickness,
            slotDepth = slotDepth,
            base = base,
            negative = negative,
            center = center
        );
    }
}

/**
 * Draws the barrier holder for a straight chunk
 * @param Number length - The length of the chunk
 * @param Number bodyThickness - The thickness of the barrier body.
 * @param Number slotDepth - The depth of the slot that will hold the barrier body.
 * @param Number barrierBase - The base value used to design the barrier holder.
 * @param Number notchBase - The width of a notch base.
 */
module straightBarrierHolder(length, bodyThickness, slotDepth, barrierBase, notchBase) {
    difference() {
        union() {
            rotate([90, 0, 90]) {
                negativeExtrude(height=length, center=true) {
                    barrierHolderProfile(
                        slotWidth = bodyThickness + printTolerance,
                        slotDepth = slotDepth,
                        base = barrierBase
                    );
                }
            }
            translateZ(barrierBase) {
                rotateX(90) {
                    barrierNotchesFull(
                        length = length,
                        thickness = bodyThickness + barrierBase,
                        slotDepth = slotDepth,
                        base = notchBase - printTolerance,
                        negative = false,
                        center = true
                    );
                }
            }
            translateX(-length / 2) {
                barrierHook(
                    base = notchBase,
                    thickness = barrierBase - printResolution * 2,
                    negative = false
                );
            }
        }
        translateX(length / 2) {
            barrierHook(
                base = notchBase + printTolerance,
                thickness = barrierBase - printResolution,
                negative = true
            );
        }
    }
}

/**
 * Draws the barrier body for a straight chunk
 * @param Number length - The length of the chunk
 * @param Number height - The height of the chunk
 * @param Number thickness - The thickness of the barrier body.
 * @param Number slotDepth - The depth of the slot that will hold the barrier body.
 * @param Number notchBase - The width of a notch base.
 */
module barrierBody(length, height, thickness, slotDepth, notchBase) {
    difference() {
        box(size = [length, height, thickness], center = true);

        repeatMirror(axis=[0, 1, 0]) {
            translateY(-height / 2) {
                translateX(-length / 2) {
                    barrierNotches(
                        length = length,
                        thickness = thickness + 1,
                        slotDepth = slotDepth,
                        base = notchBase + printTolerance,
                        negative = true,
                        center = true
                    );
                }
            }
        }
    }
}

/**
 * Draws the full barrier body for a straight chunk
 * @param Number length - The length of the chunk
 * @param Number height - The height of the chunk
 * @param Number thickness - The thickness of the barrier body.
 * @param Number slotDepth - The depth of the slot that will hold the barrier body.
 * @param Number notchBase - The width of a notch base.
 */
module barrierBodyFull(length, height, thickness, slotDepth, notchBase) {
    difference() {
        box(size = [length, height, thickness], center = true);

        repeatMirror(axis=[0, 1, 0]) {
            translateY(-height / 2) {
                barrierNotchesFull(
                    length = length,
                    thickness = thickness + 1,
                    slotDepth = slotDepth,
                    base = notchBase + printTolerance,
                    negative = true,
                    center = true
                );
            }
        }
    }
}
