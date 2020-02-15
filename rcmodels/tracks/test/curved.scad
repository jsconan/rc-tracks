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
 * Test the curved elements shapes.
 *
 * @author jsconan
 */

// Import the project's setup.
include <setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=mode) {

    distribute(intervalY=length * 3, center=true) {

        // test the main shape of a barrier holder for a curved track element, short curve, right turned
        curvedBarrierMain(
            length = length,
            thickness = thickness,
            base = base,
            ratio = 0.5,
            right = true
        );

        // test the main shape of a barrier holder for a curved track element, short curve, left turned
        curvedBarrierMain(
            length = length,
            thickness = thickness,
            base = base,
            ratio = 0.5,
            right = false
        );

        distributeRotate(center=true) {

            // test the main shape of a barrier holder for a curved track element, inner curve, right turned
            curvedBarrierMain(
                length = length,
                thickness = thickness,
                base = base,
                ratio = getInnerCurveRatio(length, radius),
                right = true
            );

            // test the main shape of a barrier holder for a curved track element, outer curve, right turned
            curvedBarrierMain(
                length = length,
                thickness = thickness,
                base = base,
                ratio = getOuterCurveRatio(length, width, radius),
                right = true
            );

            // test the main shape of a barrier holder for a curved track element, inner curve, left turned
            curvedBarrierMain(
                length = length,
                thickness = thickness,
                base = base,
                ratio = getInnerCurveRatio(length, radius),
                right = false
            );

            // test the main shape of a barrier holder for a curved track element, outer curve, left turned
            curvedBarrierMain(
                length = length,
                thickness = thickness,
                base = base,
                ratio = getOuterCurveRatio(length, width, radius),
                right = false
            );

        }

        // test the barrier notch shape for a curved track element
        barrierNotchCurved(
            radius = length,
            thickness = thickness,
            base = base,
            distance = printTolerance
        );

        // test the barrier holder shape for a curved track element, short curve, right turned
        curvedBarrierHolder(
            length = length,
            thickness = thickness,
            base = base,
            ratio = 0.5,
            right = true
        );

        // test the barrier holder shape for a curved track element, short curve, left turned
        curvedBarrierHolder(
            length = length,
            thickness = thickness,
            base = base,
            ratio = 0.5,
            right = false
        );

        distributeRotate(center=true) {

            // test the barrier holder shape for a curved track element, inner curve, right turned
            curvedBarrierHolder(
                length = length,
                thickness = thickness,
                base = base,
                ratio = getInnerCurveRatio(length, radius),
                right = true
            );

            // test the barrier holder shape for a curved track element, outer curve, right turned
            curvedBarrierHolder(
                length = length,
                thickness = thickness,
                base = base,
                ratio = getOuterCurveRatio(length, width, radius),
                right = true
            );

            // test the barrier holder shape for a curved track element, inner curve, left turned
            curvedBarrierHolder(
                length = length,
                thickness = thickness,
                base = base,
                ratio = getInnerCurveRatio(length, radius),
                right = false
            );

            // test the barrier holder shape for a curved track element, outer curve, left turned
            curvedBarrierHolder(
                length = length,
                thickness = thickness,
                base = base,
                ratio = getOuterCurveRatio(length, width, radius),
                right = false
            );

        }

    }
}
