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
 * Defines the curved track parts.
 *
 * @author jsconan
 */

/**
 * Gets the outer length of the shape of a curved barrier.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The extrusion angle.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @returns Number
 */
function getCurvedBarrierLength(radius, angle, width, height) =
    getChordLength(angle, radius + width / 2) +
    getBarrierLinkLength(width, height) * cos((CURVE_ANGLE - getCurveRotationAngle(angle)) / 2)
;

/**
 * Gets the outer width of the shape of a curved barrier.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The extrusion angle.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @returns Number
 */
function getCurvedBarrierWidth(radius, angle, width, height) =
    getChordHeight(angle, radius - width / 2) + width +
    getBarrierLinkLength(width, height) * sin((CURVE_ANGLE - getCurveRotationAngle(angle)) / 2)
;

/**
 * Adds the links to a curved element.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The extrusion angle.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Boolean [right] - Tells on which side is the male link (default on the left).
 */
module curvedLinks(radius, angle, width, height, right=false) {
    linkHeight = getBarrierLinkHeight(width, height) - layerHeight;

    linkRotationMale = right ? CURVE_ANGLE : 0;
    linkPositionMale = right ? [radius, 0, -height / 2] : [0, radius, -height / 2];
    linkDirectionMale = right ? 0 : angle - CURVE_ANGLE;

    linkRotationFemale = right ? CURVE_ANGLE : -CURVE_ANGLE;
    linkPositionFemale = right ? [radius, 0, -height / 2 - ALIGN] : [radius, 0, -height / 2 - ALIGN];
    linkDirectionFemale = right ? angle : 0;

    rotateZ(linkDirectionMale) {
        translate(linkPositionMale) {
            rotateZ(linkRotationMale) {
                barrierLink(
                    width = width,
                    height = linkHeight,
                    distance = -printTolerance,
                    neckDistance = printTolerance
                );
            }
        }
    }
    difference() {
        children();
        rotateZ(linkDirectionFemale) {
            translate(linkPositionFemale) {
                rotateZ(linkRotationFemale) {
                    barrierLink(
                        width = width,
                        height = linkHeight + ALIGN,
                        distance = printTolerance,
                        neckDistance = 0
                    );
                }
            }
        }
    }
}

/**
 * Adds the fastener holes to a curved element.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The extrusion angle.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number diameter - The diameter of the fasteners.
 * @param Number headDiameter - The diameter of the fasteners head.
 * @param Number headHeight - The height of the fasteners head.
 * @param Number [holes] - The number of holes to drill.
 */
module curvedFastenerHoles(radius, angle, width, height, diameter, headDiameter, headHeight, holes=FASTENER_HOLES) {
    holeSectorAngle = angle * (holes - 1) / holes;

    difference() {
        children();
        rotateZ((angle - holeSectorAngle) / 2) {
            repeatRotate(angle=holeSectorAngle, count=holes) {
                translateX(radius) {
                    barrierFastenerHole(
                        width = width,
                        height = height,
                        diameter = diameter,
                        headDiameter = headDiameter,
                        headHeight = headHeight,
                        distance = 0
                    );
                }
            }
        }
    }
}

/**
 * Draws the shape of a straight barrier.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The extrusion angle.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 */
module curvedBarrierBody(radius, angle, width, height) {
    extrudeCurvedProfile(radius=radius, angle=angle) {
        barrierProfile(
            width = width,
            height = height,
            distance = 0
        );
    }
}

/**
 * Draws the shape of a curved barrier.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The extrusion angle.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number diameter - The diameter of the fasteners.
 * @param Number headDiameter - The diameter of the fasteners head.
 * @param Number headHeight - The height of the fasteners head.
 * @param Boolean [right] - Tells on which side is the male link (default on the left).
 * @param Number [holes] - The number of holes to drill.
 */
module curvedBarrier(radius, angle, width, height, diameter, headDiameter, headHeight, right=false, holes=FASTENER_HOLES) {
    placeCurvedElement(radius=radius, angle=angle) {
        curvedFastenerHoles(radius=radius, angle=angle, width=width, height=height, diameter=diameter, headDiameter=headDiameter, headHeight=headHeight, holes=holes) {
            curvedLinks(radius=radius, angle=angle, width=width, height=height, right=right) {
                curvedBarrierBody(radius=radius, angle=angle, width=width, height=height);
            }
        }
    }
}
