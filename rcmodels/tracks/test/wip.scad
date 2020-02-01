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
 * Work in progress.
 *
 * @author jsconan
 * @version 0.1.0
 */

// Import the project's setup.
include <../config/setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {

    length = 50;
    height = 30;
    thickness = 0.6;
    slotDepth = 6;
    base = 2;
    distance = 0.1;

    distribute([length, 0, 0], center=true) {
        distribute([0, height, 0], center=true) {

            // test the barrier holder shape for a straight chunk
            straightBarrierHolder(
                length = length,
                bodyThickness = thickness,
                slotDepth = slotDepth,
                barrierBase = base,
                notchBase = base
            );

            // test the full barrier body shape for a straight chunk
            barrierBodyFull(
                length = length,
                height = height,
                thickness = thickness,
                slotDepth = slotDepth,
                notchBase = base
            );

            // test the barrier link shape
            barrierLink(
                height = 5,
                base = base,
                distance = distance,
                center = false
            );

            // test the barrier body shape for a straight chunk
            barrierBody(
                length = getCurveRemainingLength(length),
                height = height,
                thickness = thickness,
                slotDepth = slotDepth,
                notchBase = base
            );

            // test the barrier notch shape
            barrierNotch(
                thickness = thickness,
                slotDepth = slotDepth,
                base = base,
                direction = -1,
                negative = true,
                center = true
            );

        }
        distribute([0, 10, 0], center=true) {

            // test the curved barrier notch
            curveBarrierNotch(
                radius = length,
                thickness = thickness,
                slotDepth = slotDepth,
                base = base,
                direction = 1,
                negative = true
            );

            // test the barrier link profile
            barrierLinkProfile(
                base = base,
                distance = distance
            );

            // test the barrier profile
            barrierHolderProfile(
                slotWidth = thickness,
                slotDepth = slotDepth,
                base = base
            );

            // test the barrier notch profile
            barrierNotchProfile(
                slotDepth = slotDepth,
                base = base,
                direction = -1,
                negative = true
            );

            // test the barrier notches profile
            barrierNotchesProfile(
                length = length / 2,
                slotDepth = slotDepth,
                base = base,
                negative = true
            );

            // test the barrier notches shape
            barrierNotches(
                length = length,
                thickness = thickness,
                slotDepth = slotDepth,
                base = base,
                negative = true,
                center = true
            );

            // test the barrier notches shape for a full chunk
            barrierNotchesFull(
                length = length,
                thickness = thickness,
                slotDepth = slotDepth,
                base = base,
                negative = true,
                center = true
            );

            // test the barrier holder shape for a curved chunk
            curveBarrierHolder(
                length = length,
                bodyThickness = thickness,
                slotDepth = slotDepth,
                barrierBase = base,
                notchBase = base,
                ratio = 1
            );

        }
    }
}
