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

    distribute(intervalX=length * 3, center=true) {

        distribute(intervalY=length * 3, center=true) {

            // test the main shape of a curved barrier holder, short curve, right turned
            curvedBarrierMain(
                length = length,
                thickness = thickness,
                base = base,
                ratio = 0.5,
                right = true
            );

            // test the main shape of a curved barrier holder, short curve, left turned
            curvedBarrierMain(
                length = length,
                thickness = thickness,
                base = base,
                ratio = 0.5,
                right = false
            );

            distributeRotate(center=true) {

                // test the main shape of a curved barrier holder, inner curve, right turned
                curvedBarrierMain(
                    length = length,
                    thickness = thickness,
                    base = base,
                    ratio = getInnerCurveRatio(length, radius),
                    right = true
                );

                // test the main shape of a curved barrier holder, outer curve, right turned
                curvedBarrierMain(
                    length = length,
                    thickness = thickness,
                    base = base,
                    ratio = getOuterCurveRatio(length, width, radius),
                    right = true
                );

                // test the main shape of a curved barrier holder, inner curve, left turned
                curvedBarrierMain(
                    length = length,
                    thickness = thickness,
                    base = base,
                    ratio = getInnerCurveRatio(length, radius),
                    right = false
                );

                // test the main shape of a curved barrier holder, outer curve, left turned
                curvedBarrierMain(
                    length = length,
                    thickness = thickness,
                    base = base,
                    ratio = getOuterCurveRatio(length, width, radius),
                    right = false
                );

            }
        }

        distribute(intervalY=length * 3, center=true) {

            // test the shape of the curved barrier holder, short curve, right turned
            curvedBarrierHolder(
                length = length,
                thickness = thickness,
                base = base,
                ratio = 0.5,
                right = true
            );

            // test the shape of the curved barrier holder, short curve, left turned
            curvedBarrierHolder(
                length = length,
                thickness = thickness,
                base = base,
                ratio = 0.5,
                right = false
            );

            distributeRotate(center=true) {

                // test the shape of the curved barrier holder, inner curve, right turned
                curvedBarrierHolder(
                    length = length,
                    thickness = thickness,
                    base = base,
                    ratio = getInnerCurveRatio(length, radius),
                    right = true
                );

                // test the shape of the curved barrier holder, outer curve, right turned
                curvedBarrierHolder(
                    length = length,
                    thickness = thickness,
                    base = base,
                    ratio = getOuterCurveRatio(length, width, radius),
                    right = true
                );

                // test the shape of the curved barrier holder, inner curve, left turned
                curvedBarrierHolder(
                    length = length,
                    thickness = thickness,
                    base = base,
                    ratio = getInnerCurveRatio(length, radius),
                    right = false
                );

                // test the shape of the curved barrier holder, outer curve, left turned
                curvedBarrierHolder(
                    length = length,
                    thickness = thickness,
                    base = base,
                    ratio = getOuterCurveRatio(length, width, radius),
                    right = false
                );

            }

        }

        distribute(intervalY=length * 3, center=true) {

            // test the shape of a curved unibody barrier, short curve, right turned
            curvedBarrierUnibody(
                length = length,
                height = height,
                thickness = thickness,
                base = base,
                ratio = 0.5,
                right = true
            );

            // test the shape of a curved unibody barrier, short curve, left turned
            curvedBarrierUnibody(
                length = length,
                height = height,
                thickness = thickness,
                base = base,
                ratio = 0.5,
                right = false
            );

            distributeRotate(center=true) {

                // test the shape of a curved unibody barrier, inner curve, right turned
                curvedBarrierUnibody(
                    length = length,
                    height = height,
                    thickness = thickness,
                    base = base,
                    ratio = getInnerCurveRatio(length, radius),
                    right = true
                );

                // test the shape of a curved unibody barrier, outer curve, right turned
                curvedBarrierUnibody(
                    length = length,
                    height = height,
                    thickness = thickness,
                    base = base,
                    ratio = getOuterCurveRatio(length, width, radius),
                    right = true
                );

                // test the shape of a curved unibody barrier, inner curve, left turned
                curvedBarrierUnibody(
                    length = length,
                    height = height,
                    thickness = thickness,
                    base = base,
                    ratio = getInnerCurveRatio(length, radius),
                    right = false
                );

                // test the shape of a curved unibody barrier, outer curve, left turned
                curvedBarrierUnibody(
                    length = length,
                    height = height,
                    thickness = thickness,
                    base = base,
                    ratio = getOuterCurveRatio(length, width, radius),
                    right = false
                );

            }

        }

    }
}
