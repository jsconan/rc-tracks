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
 * Gets the outer length of the shape of a curved barrier in the female variant.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The extrusion angle.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @returns Number
 */
function getCurvedBarrierFemaleLength(radius, angle, width, height) =    
    getChordLength(angle, radius + width / 2)
;

/**
 * Gets the outer width of the shape of a curved barrier in the female variant.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The extrusion angle.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @returns Number
 */
function getCurvedBarrierFemaleWidth(radius, angle, width, height) =
    getChordHeight(angle, radius - width / 2) + width
;

/**
 * Gets the outer length of the shape of a curved barrier in the male variant.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The extrusion angle.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @returns Number
 */
function getCurvedBarrierMaleLength(radius, angle, width, height) =
    getCurvedBarrierFemaleLength(radius, angle, width, height) +
    getBarrierLinkLength(width, height) * cos((CURVE_ANGLE - getCurveRotationAngle(angle)) / 2) * 2
;

/**
 * Gets the outer width of the shape of a curved barrier in the male variant.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The extrusion angle.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @returns Number
 */
function getCurvedBarrierMaleWidth(radius, angle, width, height) =
    getCurvedBarrierFemaleWidth(radius, angle, width, height) +
    getBarrierLinkLength(width, height) * sin((CURVE_ANGLE - getCurveRotationAngle(angle)) / 2)
;

/**
 * Adds the male links to a curved element.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The extrusion angle.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 */
module curvedLinkMale(radius, angle, width, height) {
    linkHeight = getBarrierLinkHeight(width, height) - layerHeight;

    translate([radius, 0, -height / 2]) {
        rotateZ(CURVE_ANGLE) {
            barrierLink(
                width = width,
                height = linkHeight,
                distance = -printTolerance
            );
        }
    }
    rotateZ(angle - CURVE_ANGLE) {
        translate([0, radius, -height / 2]) {        
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
 * Adds the female links to a curved element.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The extrusion angle.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 */
module curvedLinkFemale(radius, angle, width, height) {
    linkHeight = getBarrierLinkHeight(width, height) + layerHeight;

    difference() {
        children();
        translate([radius, 0, -height / 2 - ALIGN]) {
            rotateZ(-CURVE_ANGLE) {
                barrierLink(
                    width = width,
                    height = linkHeight + ALIGN,
                    distance = printTolerance
                );
            }
        }
        rotateZ(angle) {
            translate([radius, 0, -height / 2 - ALIGN]) {
                rotateZ(CURVE_ANGLE) {
                    barrierLink(
                        width = width,
                        height = linkHeight + ALIGN,
                        distance = printTolerance
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
                        distance = printTolerance
                    );
                }
            }
        }
    }
}

/**
 * Place a curved element.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The angle of the curve.
 */
module placeCurvedElement(radius, angle) {
    translateY(getChordHeight(angle, radius) / 2 - radius) {
        rotateZ(getCurveRotationAngle(angle)) {
            children();
        }
    }
}

/**
 * Extrudes the profile on the expected circle path.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The extrusion angle.
 */
module extrudeCurvedProfile(radius, angle) {
    rotate_extrude(angle=angle, convexity=10) {
        translateX(radius) {
            children();
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
module curvedBarrier(radius, angle, width, height) {
    extrudeCurvedProfile(radius=radius, angle=angle) {
        barrierProfile(
            width = width,
            height = height,
            distance = 0
        );
    }
}

/**
 * Draws the shape of a curved barrier in the male variant.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The extrusion angle.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number diameter - The diameter of the fasteners.
 * @param Number headDiameter - The diameter of the fasteners head.
 * @param Number headHeight - The height of the fasteners head.
 * @param Number [holes] - The number of holes to drill.
 */
module curvedBarrierMale(radius, angle, width, height, diameter, headDiameter, headHeight, holes=FASTENER_HOLES) {
    placeCurvedElement(radius=radius, angle=angle) {
        curvedFastenerHoles(radius=radius, angle=angle, width=width, height=height, diameter=diameter, headDiameter=headDiameter, headHeight=headHeight, holes=holes) {
            curvedLinkMale(radius=radius, angle=angle, width=width, height=height) {
                curvedBarrier(radius=radius, angle=angle, width=width, height=height);
            }
        }
    }
}

/**
 * Draws the shape of a curved barrier in the female variant.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The extrusion angle.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number diameter - The diameter of the fasteners.
 * @param Number headDiameter - The diameter of the fasteners head.
 * @param Number headHeight - The height of the fasteners head.
 * @param Number [holes] - The number of holes to drill.
 */
module curvedBarrierFemale(radius, angle, width, height, diameter, headDiameter, headHeight, holes=FASTENER_HOLES) {
    placeCurvedElement(radius=radius, angle=angle) {
        curvedFastenerHoles(radius=radius, angle=angle, width=width, height=height, diameter=diameter, headDiameter=headDiameter, headHeight=headHeight, holes=holes) {
            curvedLinkFemale(radius=radius, angle=angle, width=width, height=height) {
                curvedBarrier(radius=radius, angle=angle, width=width, height=height);
            }
        }
    }
}
