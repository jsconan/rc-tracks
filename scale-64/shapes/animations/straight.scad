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
 * Defines the shapes for the animated straight models.
 *
 * @author jsconan
 */

/**
 * Animates the construction of a straight section.
 * @param Number [start] - The start threshold under what the from-coordinates will persist and above what it will be interpolated.
 * @param Number [end] - The end threshold above what the to-coordinates will persist and under what it will be interpolated.
 * @param Number [domain] - The percentage domain applied to compute the percentage ratio for the thresholds (default: 100).
 * @param Number [ratio] - The size factor.
 */
module animatedStraightSection(start, end, domain, ratio=1) {
    elements = getStraightSectionSteps(ratio);
    steps = len(elements);

    for (step = [0 : steps - 1]) {
        element = elements[step][0];
        i = elements[step][1];
        right = elements[step][2];

        barrierX = getStraightBarrierX(i, ratio, right);
        barrierY = getStraightBarrierY(i, ratio, right);
        rotation = getStraightRotation(i, ratio, right);

        if (element == "peg") {
            color(colorPeg) {
                animateStep(
                    step = step,
                    translateTo=[barrierX, barrierY, 0],
                    steps=steps, start=start, end=end, domain=domain
                ) {
                    barrierPegSet();
                }
            }
        }
        if (element == "barrier") {
            color(even(i) ? colorEven : colorOdd) {
                animateStep(
                    step = step,
                    translateTo = [barrierX, barrierY, trackGroundThickness],
                    rotateTo = zAxis3D(rotation),
                    steps=steps, start=start, end=end, domain=domain
                ) {
                    straightBarrierSet();
                }
            }
        }
        if (element == "ground") {
            color(colorGround) {
                animateStep(step=step, steps=steps, start=start, end=end, domain=domain) {
                    straightTrackSectionGround(ratio=ratio);
                }
            }
        }
    }
}

/**
 * Animates the construction of a straight full tile.
 * @param Number [start] - The start threshold under what the from-coordinates will persist and above what it will be interpolated.
 * @param Number [end] - The end threshold above what the to-coordinates will persist and under what it will be interpolated.
 * @param Number [domain] - The percentage domain applied to compute the percentage ratio for the thresholds (default: 100).
 * @param Number [ratio] - The size factor.
 */
module animatedStraightTile(start, end, domain, ratio=1) {
    color(colorTile) {
        animateStep(step=0, steps=1, start=start, end=end, domain=domain) {
            straightTrackTile(ratio=ratio);
        }
    }
}

/**
 * An assembled straight section.
 * @param Number [ratio] - The size factor.
 */
module straightSection(ratio=1) {
    elements = getStraightSectionSteps(ratio);
    steps = len(elements);

    for (step = [0 : steps - 1]) {
        element = elements[step][0];
        i = elements[step][1];
        right = elements[step][2];

        barrierX = getStraightBarrierX(i, ratio, right);
        barrierY = getStraightBarrierY(i, ratio, right);
        rotation = getStraightRotation(i, ratio, right);

        if (element == "peg") {
            color(colorPeg) {
                translate([barrierX, barrierY, 0]) {
                    barrierPegSet();
                }
            }
        }
        if (element == "barrier") {
            color(even(i) ? colorEven : colorOdd) {
                translate([barrierX, barrierY, trackGroundThickness]) {
                    rotate(zAxis3D(rotation)) {
                        straightBarrierSet();
                    }
                }
            }
        }
        if (element == "ground") {
            color(colorGround) {
                straightTrackSectionGround(ratio=ratio);
            }
        }
    }
}
