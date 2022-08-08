/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2022 Jean-Sebastien CONAN
 *
 * This file is part of jsconan/rc-tracks.
 *
 * jsconan/rc-tracks is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * jsconan/rc-tracks is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with jsconan/rc-tracks. If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * A race track system for 1/64 to 1/76 scale RC cars.
 *
 * Animated examples for each type of full tile.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../config/setup.scad>

// Setup the viewport
$vpr = [55, 0, 25];
$vpt = [0, 0, 0];
$vpd = 500;

// Prepare the list of animations
list = buildAnimationList([
    getAnimationThresholds("starting", 1, 1),
    getAnimationThresholds("straight", 1, 1),
    getAnimationThresholds("enlarged", 1, 1),
    getAnimationThresholds("curve", 1, 1),
    getAnimationThresholds("curve", 2, 1),
]);
steps = getAnimationSteps(list);
count = len(list);

// Show the number of steps for all animations
if (showSteps) {
    echo(steps);
}

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {

    // Process the animations
    for (i = [0 : count - 1]) {
        type = list[i][0];
        ratio = list[i][1];
        start = list[i][2];
        present = list[i][3];
        end = list[i][4];

        startThreshold = interpolationThreshold(step=start, steps=steps);
        endThreshold = interpolationThreshold(step=present, steps=steps);

        presentSteps(from=start, to=end, steps=steps) {
            if (type == "starting") {
                animatedStraightTile(
                    start = startThreshold,
                    end = endThreshold,
                    ratio = ratio,
                    starting = true
                );
            }
            if (type == "straight") {
                animatedStraightTile(
                    start = startThreshold,
                    end = endThreshold,
                    ratio = ratio,
                    starting = false
                );
            }
            if (type == "enlarged") {
                animatedEnlargedCurveTile(
                    start = startThreshold,
                    end = endThreshold,
                    ratio = ratio
                );
            }
            if (type == "curve") {
                animatedCurvedTile(
                    start = startThreshold,
                    end = endThreshold,
                    ratio = ratio
                );
            }
        }
    }

}
