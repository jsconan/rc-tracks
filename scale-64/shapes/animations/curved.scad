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
 * Defines the shapes for the animated curved models.
 *
 * @author jsconan
 */

/**
 * Animates the construction of a curved section.
 * @param Number [start] - The start threshold under what the from-coordinates will persist and above what it will be interpolated.
 * @param Number [end] - The end threshold above what the to-coordinates will persist and under what it will be interpolated.
 * @param Number [domain] - The percentage domain applied to compute the percentage ratio for the thresholds (default: 100).
 * @param Number [ratio] - The size factor.
 */
module animatedCurvedSection(start, end, domain, ratio=1) {
    sizeRatio = max(1, ratio);
    elements = getCurveSectionSteps(ratio);
    steps = len(elements);

    for (step = [0 : steps - 1]) {
        element = elements[step][0];
        i = elements[step][1];
        inner = elements[step][2];

        barrierX = getCurveBarrierX(i, ratio, inner);
        barrierY = getCurveBarrierY(i, ratio, inner);
        rotation = getCurveRotation(i, ratio, inner);

        if (element == "peg") {
            color(colorPeg) {
                animateStep(
                    step = step,
                    translateTo = [barrierX, barrierY, 0],
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
                    if (inner) {
                        innerCurveBarrierSet(sizeRatio);
                    } else {
                        outerCurveBarrierSet(sizeRatio);
                    }
                }
            }
        }
        if (element == "ground") {
            color(colorGround) {
                animateStep(step=step, steps=steps, start=start, end=end, domain=domain) {
                    curvedTrackSectionGround(ratio=ratio);
                }
            }
        }
    }
}

/**
 * Animates the construction of an enlarged curve section.
 * @param Number [start] - The start threshold under what the from-coordinates will persist and above what it will be interpolated.
 * @param Number [end] - The end threshold above what the to-coordinates will persist and under what it will be interpolated.
 * @param Number [domain] - The percentage domain applied to compute the percentage ratio for the thresholds (default: 100).
 * @param Number [ratio] - The size factor.
 */
module animatedEnlargedCurveSection(start, end, domain, ratio=1) {
    sizeRatio = max(1, ratio);
    elements = getEnlargedCurveSectionSteps(ratio);
    steps = len(elements);

    for (step = [0 : steps - 1]) {
        element = elements[step][0];
        type = elements[step][1];
        i = elements[step][2];

        if (type == "side") {
            right = elements[step][3];
            barrierX = getEnlargedCurveSideBarrierX(i, ratio, right);
            barrierY = getEnlargedCurveSideBarrierY(i, ratio, right);
            rotation = getEnlargedCurveSideRotation(i, ratio, right);

            if (element == "peg") {
                color(colorPeg) {
                    animateStep(
                        step = step,
                        translateTo = [barrierX, barrierY, 0],
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
        }
        if (type == "curve") {
            inner = elements[step][3];
            barrierX = getEnlargedCurveBarrierX(i, ratio, inner);
            barrierY = getEnlargedCurveBarrierY(i, ratio, inner);
            rotation = getEnlargedCurveRotation(i, ratio, inner);

            if (element == "peg") {
                color(colorPeg) {
                    animateStep(
                        step = step,
                        translateTo = [barrierX, barrierY, 0],
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
                        if (inner) {
                            innerCurveBarrierSet(sizeRatio);
                        } else {
                            enlargedCurveBarrierSet(sizeRatio);
                        }
                    }
                }
            }
        }
        if (element == "ground") {
            color(colorGround) {
                animateStep(step=step, steps=steps, start=start, end=end, domain=domain) {
                    enlargedCurveTrackSectionGround(ratio=ratio);
                }
            }
        }
    }
}

/**
 * An assembled curved section.
 * @param Number [ratio] - The size factor.
 */
module curvedSection(ratio=1) {
    sizeRatio = max(1, ratio);
    elements = getCurveSectionSteps(ratio);
    steps = len(elements);

    for (step = [0 : steps - 1]) {
        element = elements[step][0];
        i = elements[step][1];
        inner = elements[step][2];

        barrierX = getCurveBarrierX(i, ratio, inner);
        barrierY = getCurveBarrierY(i, ratio, inner);
        rotation = getCurveRotation(i, ratio, inner);

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
                        if (inner) {
                            innerCurveBarrierSet(sizeRatio);
                        } else {
                            outerCurveBarrierSet(sizeRatio);
                        }
                    }
                }
            }
        }
        if (element == "ground") {
            color(colorGround) {
                curvedTrackSectionGround(ratio=ratio);
            }
        }
    }
}

/**
 * An assembled enlarged curve section.
 * @param Number [ratio] - The size factor.
 */
module enlargedCurveSection(ratio=1) {
    sizeRatio = max(1, ratio);
    elements = getEnlargedCurveSectionSteps(ratio);
    steps = len(elements);

    for (step = [0 : steps - 1]) {
        element = elements[step][0];
        type = elements[step][1];
        i = elements[step][2];

        if (type == "side") {
            right = elements[step][3];
            barrierX = getEnlargedCurveSideBarrierX(i, ratio, right);
            barrierY = getEnlargedCurveSideBarrierY(i, ratio, right);
            rotation = getEnlargedCurveSideRotation(i, ratio, right);

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
        }
        if (type == "curve") {
            inner = elements[step][3];
            barrierX = getEnlargedCurveBarrierX(i, ratio, inner);
            barrierY = getEnlargedCurveBarrierY(i, ratio, inner);
            rotation = getEnlargedCurveRotation(i, ratio, inner);

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
                            if (inner) {
                                innerCurveBarrierSet(sizeRatio);
                            } else {
                                enlargedCurveBarrierSet(sizeRatio);
                            }
                        }
                    }
                }
            }
        }
        if (element == "ground") {
            color(colorGround) {
                enlargedCurveTrackSectionGround(ratio=ratio);
            }
        }
    }
}
