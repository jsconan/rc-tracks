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
 * Gets the outer length of the shape of a straight barrier in the female variant.
 * @param Number length - The length of the barrier.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @returns Number
 */
function getStraightBarrierFemaleLength(length, width, height) = length;

/**
 * Gets the outer width of the shape of a straight barrier in the female variant.
 * @param Number length - The length of the barrier.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @returns Number
 */
function getStraightBarrierFemaleWidth(length, width, height) = width;

/**
 * Gets the outer length of the shape of a straight barrier in the male variant.
 * @param Number length - The length of the barrier.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @returns Number
 */
function getStraightBarrierMaleLength(length, width, height) =
    getStraightBarrierFemaleLength(length, width, height) + 
    getBarrierLinkLength(width, height) * 2
;

/**
 * Gets the outer width of the shape of a straight barrier in the male variant.
 * @param Number length - The length of the barrier.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @returns Number
 */
function getStraightBarrierMaleWidth(length, width, height) =
    getStraightBarrierFemaleWidth(length, width, height)
;

/**
 * Adds the male links to a straight element.
 * @param Number length - The length of the barrier.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 */
module straightLinkMale(length, width, height) {
    linkHeight = getBarrierLinkHeight(width, height) - layerHeight;

    repeatRotate(count=2) {
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
        repeatRotate(count=2) {
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
 * @param Number [holes] - The number of holes to drill.
 */
module straightFastenerHoles(length, width, height, diameter, headDiameter, headHeight, holes=FASTENER_HOLES) {
    interval = length / holes;
    
    difference() {
        children();
        repeat(count=holes, intervalX=interval, center=true) {
            barrierFastenerHole(
                width = width,
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
    rotate([RIGHT, 0, RIGHT]) {
        linear_extrude(height=length, center=true, convexity=10) {
            children();
        }
    }
}

/**
 * Draws the shape of a straight barrier.
 * @param Number length - The length of the barrier.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 */
module straightBarrier(length, width, height) {
    extrudeStraightProfile(length=length) {
        barrierProfile(
            width = width,
            height = height,
            distance = 0
        );
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
 * @param Number [holes] - The number of holes to drill.
 */
module straightBarrierMale(length, width, height, diameter, headDiameter, headHeight, holes=FASTENER_HOLES) {
    straightFastenerHoles(length=length, width=width, height=height, diameter=diameter, headDiameter=headDiameter, headHeight=headHeight, holes=holes) {
        straightLinkMale(length=length, width=width, height=height) {
            straightBarrier(length=length, width=width, height=height);
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
 * @param Number [holes] - The number of holes to drill.
 */
module straightBarrierFemale(length, width, height, diameter, headDiameter, headHeight, holes=FASTENER_HOLES) {
    straightFastenerHoles(length=length, width=width, height=height, diameter=diameter, headDiameter=headDiameter, headHeight=headHeight, holes=holes) {
        straightLinkFemale(length=length, width=width, height=height) {
            straightBarrier(length=length, width=width, height=height);
        }
    }
}
