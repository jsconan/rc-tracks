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
 * Defines the operators for the animations.
 *
 * @author jsconan
 */

/**
 * Animates child modules with respect to the supplied coordinates.
 * @param Vector [translateFrom] - The coordinates from where starts to interpolate the translation.
 * @param Vector [translateTo] - The coordinates to where ends to interpolate the translation.
 * @param Vector [rotateFrom] - The coordinates from where starts to interpolate the rotation.
 * @param Vector [rotateTo] - The coordinates to where ends to interpolate the rotation.
 * @param Vector [scaleFrom] - The coordinates from where starts to interpolate the scaling.
 * @param Vector [scaleTo] - The coordinates to where ends to interpolate the scaling.
 * @param Number [start] - The start threshold under what the from-coordinates will persist and above what it will be interpolated.
 * @param Number [end] - The end threshold above what the to-coordinates will persist and under what it will be interpolated.
 * @param Vector [translateValues] - A list of coordinates composing the range to interpolate the translation.
 * @param Vector [translateRange] - A pre-built interpolation range for the translation.
 * @param Vector [rotateValues] - A list of coordinates composing the range to interpolate the rotation.
 * @param Vector [rotateRange] - A pre-built interpolation range for the rotation.
 * @param Vector [scaleValues] - A list of coordinates composing the range to interpolate the scaling.
 * @param Vector [scaleRange] - A pre-built interpolation range for the scaling.
 */
module animate(
    translateFrom=ANIMATION_TRANSLATE_FROM, translateTo=ANIMATION_TRANSLATE_TO,
    rotateFrom=ANIMATION_ROTATE_FROM, rotateTo=ANIMATION_ROTATE_TO,
    scaleFrom=ANIMATION_SCALE_FROM, scaleTo=ANIMATION_SCALE_TO,
    start, end,
    translateValues, translateRange,
    rotateValues, rotateRange,
    scaleValues, scaleRange
) {
    presentAnimate(start=start) {
        translateAnimate(from=translateFrom, to=translateTo, values=translateValues, range=translateRange, start=start, end=end) {
            rotateAnimate(from=rotateFrom, to=rotateTo, values=rotateValues, range=rotateRange, start=start, end=end) {
                scaleAnimate(from=scaleFrom, to=scaleTo, values=scaleValues, range=scaleRange, start=start, end=end) {
                    children();
                }
            }
        }
    }
}

/**
 * Animates child modules for a particular step.
 * @param Number step - The step to animate.
 * @param Number steps - The overall number of expected animated teps.
 * @param Vector [translateTo] - The coordinates to where ends to interpolate the translation.
 * @param Vector [rotateTo] - The coordinates to where ends to interpolate the rotation.
 * @param Number [start] - The start threshold under what the from-coordinates will persist and above what it will be interpolated.
 * @param Number [end] - The end threshold above what the to-coordinates will persist and under what it will be interpolated.
 * @param Number [domain] - The percentage domain used to compute the thresholds (default: 100).
 */
module animateStep(step, steps, translateTo, rotateTo, start, end, domain) {
    animate(
        translateTo = translateTo,
        rotateTo = rotateTo,
        start = interpolationThreshold(step=step, steps=steps, start=start, end=end, domain=domain),
        end = interpolationThreshold(step=step + ANIMATION_ANIMATE_STEPS, steps=steps, start=start, end=end, domain=domain)
    ) {
        children();
    }
}

/**
 * Slides the child modules for a particular step.
 * @param Number step - The step to animate.
 * @param Number steps - The overall number of expected animated teps.
 */
module animateSlide(step, steps) {
    start = interpolationThreshold(step=step, steps=steps);
    end = interpolationThreshold(step=step + ANIMATION_SLIDE_STEPS, steps=steps);

    translateAnimate(
        from = ANIMATION_SLIDE_FROM,
        to = ANIMATION_SLIDE_TO,
        start = start,
        end = end
    ) {
        rotateAnimate(
            from = ANIMATION_ROTATE_TO,
            to = ANIMATION_ROTATE_FROM,
            start = start,
            end = end
        ) {
            scaleAnimate(
                from = ANIMATION_SCALE_TO,
                to = ANIMATION_SCALE_FROM,
                start = start,
                end = end
            ) {
                children();
            }
        }
    }
}

/**
 * Presents the child modules between particular steps.
 * @param Number from - The first step from which present the child modules.
 * @param Number to - The last step to which present the child modules.
 * @param Number steps - The overall number of expected animated teps.
 */
module presentSteps(from, to, steps) {
    let(
        slide = to - ANIMATION_SLIDE_STEPS,
        start = interpolationThreshold(step=from, steps=steps),
        end = interpolationThreshold(step=to, steps=steps)
    ) {
        presentAnimate(start=start, end=end) {
            animateSlide(step=slide, steps=steps) {
                children();
            }
        }
    }
}
