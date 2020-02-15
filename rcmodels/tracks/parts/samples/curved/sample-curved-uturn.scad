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
 * A sample for a U-turn curve track part.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../../config/setup.scad>

/**
 * Draws the shape of a barrier border for a U-Turn.
 * @param Number length - The length of a track element.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number gap - The distance between the two side of the u-turn.
 * @param Number right - Is it the right or the left part of the track element that is added first?
 */
module uTurnSample(length, thickness, base, gap, right = false) {
    holderWidth = getBarrierHolderWidth(base);
    holderHeight = getBarrierHolderHeight(base);
    interval = (gap + holderWidth) / 2;

    difference() {
        union() {
            translateY(interval) {
                rotateZ(right ? 180 : 0) {
                    straightBarrierMain(
                        length = length,
                        thickness = thickness,
                        base = base
                    );
                }
            }
            translateY(-interval) {
                rotateZ(right ? 0 : 180) {
                    straightBarrierMain(
                        length = length,
                        thickness = thickness,
                        base = base
                    );
                }
            }
        }
        translate([length, 0, -length]) {
            box(length * 2);
        }
    }
    rotateZ(270) {
        rotate_extrude(angle=180, convexity=10) {
            translateX(interval) {
                barrierHolderProfile(
                    base = base,
                    thickness = thickness
                );
            }
        }
    }
}

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0])
    uTurnSample(
        length = sampleSize,
        thickness = barrierBodyThickness,
        base = sampleBase,
        gap = minWidth * 2,
        right = rightOriented
    );
}
