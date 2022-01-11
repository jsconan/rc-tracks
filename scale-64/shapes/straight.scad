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
 * Defines the straight track parts.
 *
 * @author jsconan
 */

/**
 * Gets the outer length of the shape of a straight barrier in the male variant.
 * @param Number length - The length of the barrier.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @returns Number
 */
function getStraightBarrierMaleLength(length, width, height) = length + getBarrierLinkLength(width, height);

/**
 * Gets the outer length of the shape of a straight barrier in the female variant.
 * @param Number length - The length of the barrier.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @returns Number
 */
function getStraightBarrierFemaleLength(length, width, height) = length;

/**
 * Adds the male links to a straight element.
 * @param Number length - The length of the barrier.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 */
module straightLinkMale(length, width, height) {
    linkHeight = getBarrierLinkHeight(width, height) - layerHeight;
    repeatMirror(axis=[1, 0, 0]) {
        translate([-length, 0, -height] / 2) {
            barrierLink(
                width = width,
                height = linkHeight,
                distance = -printTolerance
            );
        }
    }
    children();
}

/**
 * Adds the female links to a straight element.
 * @param Number length - The length of the barrier.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 */
module straightLinkFemale(length, width, height) {
    linkHeight = getBarrierLinkHeight(width, height) + layerHeight;
    difference() {
        children();
        repeatMirror(axis=[1, 0, 0]) {
            translate([length, 0, -height - ALIGN2] / 2) {
                barrierLink(
                    width = width,
                    height = linkHeight + ALIGN,
                    distance = printTolerance
                );
            }
        }
    }
}

/**
 * Adds the fastener holes to a straight element.
 * @param Number length - The length of the barrier.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number diameter - The diameter of the fasteners.
 * @param Number headDiameter - The diameter of the fasteners head.
 * @param Number headHeight - The height of the fasteners head.
 * @param Number [count] - The number of holes to drill.
 */
module straightFastenerHoles(length, width, height, diameter, headDiameter, headHeight, count=1) {
    interval = length / count;
    difference() {
        children();
        repeat(count=count, intervalX=interval, center=true) {
            barrierFastenerHole(
                height = height,
                diameter = diameter,
                headDiameter = headDiameter,
                headHeight = headHeight,
                distance = printTolerance
            );
        }
    }
}

/**
 * Extrudes the profile on the expected linear length.
 * @param Number length - The length of the element.
 */
module extrudeStraightProfile(length) {
    rotate([90, 0, 90]) {
        linear_extrude(height=length, center=true, convexity=10) {
            children();
        }
    }
}

/**
 * Draws the shape of a straight barrier in the male variant.
 * @param Number length - The length of the barrier.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number diameter - The diameter of the fasteners.
 * @param Number headDiameter - The diameter of the fasteners head.
 * @param Number headHeight - The height of the fasteners head.
 * @param Number [count] - The number of holes to drill.
 */
module straightBarrierMale(length, width, height, diameter, headDiameter, headHeight, count=1) {
    straightFastenerHoles(length=length, width=width, height=height, diameter=diameter, headDiameter=headDiameter, headHeight=headHeight, count=count) {
        straightLinkMale(length=length, width=width, height=height) {
            extrudeStraightProfile(length=length) {
                barrierProfile(
                    width = width,
                    height = height,
                    distance = 0
                );
            }
        }
    }
}

/**
 * Draws the shape of a straight barrier in the female variant.
 * @param Number length - The length of the barrier.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number diameter - The diameter of the fasteners.
 * @param Number headDiameter - The diameter of the fasteners head.
 * @param Number headHeight - The height of the fasteners head.
 * @param Number [count] - The number of holes to drill.
 */
module straightBarrierFemale(length, width, height, diameter, headDiameter, headHeight, count=1) {
    straightFastenerHoles(length=length, width=width, height=height, diameter=diameter, headDiameter=headDiameter, headHeight=headHeight, count=count) {
        straightLinkFemale(length=length, width=width, height=height) {
            extrudeStraightProfile(length=length) {
                barrierProfile(
                    width = width,
                    height = height,
                    distance = 0
                );
            }
        }
    }
}
