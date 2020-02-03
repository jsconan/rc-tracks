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
 * @version 0.2.0
 */

// Import the project's setup.
include <../config/setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {

    length = 50;
    height = 30;
    thickness = 0.6;
    wall = 0.8;
    clip = 2;
    base = 2;
    tolerance = 0.1;

    distribute([length, 0, 0], center=true) {
        distribute([0, height, 0], center=true) {

            // test the barrier holder shape for a straight track element
            straightBarrierHolder(
                length = length,
                thickness = thickness,
                base = base,
                tolerance = tolerance
            );

            // test the barrier body shape
            barrierBody(
                length = length,
                height = height,
                thickness = thickness,
                base = base,
                notches = 2,
                tolerance = tolerance
            );

            // test the barrier link shape
            barrierLink(
                height = 5,
                base = base,
                tolerance = tolerance,
                center = false
            );

            // test the wire clip profile
            wireClip(
                wall = wall,
                height = clip,
                base = base,
                thickness = thickness,
                tolerance = tolerance
            );

            // test the arch tower shape
            rotateZ(-90) {
                archTower(
                    wall = base,
                    height = height,
                    base = base,
                    thickness = thickness,
                    tolerance = tolerance
                );
            }

            // test the arch tower shape with holders, left side
            archTowerWidthHolder(
                wall = wall * 2,
                length = length,
                height = height,
                base = base,
                thickness = thickness,
                tolerance = tolerance,
                right = false
            );

            // test the arch tower shape with holders, right side
            archTowerWidthHolder(
                wall = wall * 2,
                length = length,
                height = height,
                base = base,
                thickness = thickness,
                tolerance = tolerance,
                right = true
            );

            // test the barrier body shape for the remaing of a curve
            barrierBody(
                length = getCurveRemainingLength(length),
                height = height,
                thickness = thickness,
                base = base,
                notches = 1,
                tolerance = tolerance
            );

            // test the barrier notch shape for a straight track element
            barrierNotch(
                thickness = thickness,
                base = base,
                tolerance = tolerance,
                interval = length,
                count = 2,
                center = true
            );

        }
        distribute([0, 10, 0], center=true) {

            // test the wire clip profile
            wireClipProfile(
                wall = wall,
                base = base,
                thickness = thickness,
                tolerance = tolerance
            );

            // test the barrier holder outline
            barrierHolderOutline(
                wall = wall,
                base = base,
                thickness = thickness,
                tolerance = tolerance,
                distance = 0
            );

            // test the barrier notch shape for a curved track element
            barrierNotchCurved(
                radius = length,
                thickness = thickness,
                base = base,
                tolerance = tolerance
            );

            // test the arch tower profile
            rotateZ(-90) {
                archTowerProfile(
                    wall = wall,
                    height = height,
                    base = base,
                    thickness = thickness,
                    tolerance = tolerance
                );
            }

            // test the barrier holder shape for a curved track element, right turned
            curvedBarrierHolder(
                length = length,
                thickness = thickness,
                base = base,
                tolerance = tolerance,
                ratio = 1,
                right = true
            );

            // test the barrier link profile
            barrierLinkProfile(
                base = base,
                tolerance = tolerance
            );

            // test the barrier notch profile
            barrierNotchProfile(
                base = base,
                tolerance = tolerance
            );

            // test the barrier holder profile
            barrierHolderProfile(
                base = base,
                thickness = thickness,
                tolerance = tolerance
            );

            // test the barrier holder shape for a curved track element, left turned
            curvedBarrierHolder(
                length = length,
                thickness = thickness,
                base = base,
                tolerance = tolerance,
                ratio = 1,
                right = false
            );

        }
    }
}
