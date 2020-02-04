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
 * Test the curved barrier shapes.
 *
 * @author jsconan
 * @version 0.2.0
 */

// Import the project's setup.
include <setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=mode) {

    distribute(intervalY=length * 3, center=true) {

        distributeRotate(center=true) {

            // test the main shape of a barrier holder for a curved track element, right turned
            curvedBarrierMain(
                length = length,
                thickness = thickness,
                base = base,
                ratio = 1,
                right = true
            );

            // test the main shape of a barrier holder for a curved track element with a ratio of 2, right turned
            curvedBarrierMain(
                length = length,
                thickness = thickness,
                base = base,
                ratio = 2,
                right = true
            );

            // test the main shape of a barrier holder for a curved track element, left turned
            curvedBarrierMain(
                length = length,
                thickness = thickness,
                base = base,
                ratio = 1,
                right = false
            );

            // test the main shape of a barrier holder for a curved track element with a ratio of 2, left turned
            curvedBarrierMain(
                length = length,
                thickness = thickness,
                base = base,
                ratio = 2,
                right = false
            );

        }

        // test the barrier notch shape for a curved track element
        barrierNotchCurved(
            radius = length,
            thickness = thickness,
            base = base,
            distance = tolerance
        );

        distributeRotate(center=true) {

            // test the barrier holder shape for a curved track element, right turned
            curvedBarrierHolder(
                length = length,
                thickness = thickness,
                base = base,
                ratio = 1,
                right = true
            );

            // test the barrier holder shape for a curved track element with a ratio of 2, right turned
            curvedBarrierHolder(
                length = length,
                thickness = thickness,
                base = base,
                ratio = 2,
                right = true
            );

            // test the barrier holder shape for a curved track element, left turned
            curvedBarrierHolder(
                length = length,
                thickness = thickness,
                base = base,
                ratio = 1,
                right = false
            );

            // test the barrier holder shape for a curved track element with a ratio of 2, left turned
            curvedBarrierHolder(
                length = length,
                thickness = thickness,
                base = base,
                ratio = 2,
                right = false
            );

        }

    }
}
