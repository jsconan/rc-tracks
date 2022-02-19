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
 * Defines the shapes for the curved ground tiles.
 *
 * @author jsconan
 */

/**
 * Draws the shape of a curved ground.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number thickness - The thickness of the track ground.
 * @param Number angle - The angle of the curve.
 * @param Number [ratio] - The size factor.
 */
module curvedGround(length, width, thickness, angle, ratio=1) {
    linear_extrude(height=thickness, center=true, convexity=10) {
        curvedGroundProfile(
            length = length,
            width = width,
            angle = angle,
            ratio = ratio
        );
    }
}

/**
 * Draws the shape of an enlarged curve ground.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number thickness - The thickness of the track ground.
 * @param Number [ratio] - The size factor.
 */
module enlargedCurveGround(length, width, thickness, ratio=1) {
    linear_extrude(height=thickness, center=true, convexity=10) {
        enlargedCurveGroundProfile(
            length = length,
            width = width,
            ratio = ratio
        );
    }
}

/**
 * Draws the shape of the holes for a curved ground.
 * @param Number radius - The radius of the curve at the position of the holes.
 * @param Number angle - The angle of the curve.
 * @param Number thickness - The thickness of the track ground.
 * @param Number barrierWidth - The width of the barrier.
 * @param Number barrierHeight - The height of the barrier.
 * @param Number barrierChunks - The number of barrier chunks per section.
 */
module curvedGroundHoles(radius, angle, thickness, barrierWidth, barrierHeight, barrierChunks) {
    holeSectorAngle = angle * (barrierChunks - 1) / barrierChunks;

    rotateZ((angle - holeSectorAngle) / 2) {
        repeatRotate(angle=holeSectorAngle, count=barrierChunks) {
            translateX(radius) {
                barrierPegHole(
                    width = barrierWidth,
                    height = barrierHeight,
                    thickness = thickness,
                    distance = printTolerance
                );
            }
        }
    }
}

/**
 * Draws the shape of a curved ground tile.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number thickness - The thickness of the track ground.
 * @param Number barrierWidth - The width of the barrier.
 * @param Number barrierHeight - The height of the barrier.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 */
module curvedGroundTile(length, width, thickness, barrierWidth, barrierHeight, barrierChunks, ratio=1) {
    sizeRatio = max(1, ratio);
    angle = getCurveAngle(ratio);
    innerRadius = getCurveInnerRadius(length=length, width=width, ratio=sizeRatio);
    outerRadius = getCurveOuterRadius(length=length, width=width, ratio=sizeRatio);
    barrierInnerPosition = getCurveInnerBarrierPosition(length=length, width=width, barrierWidth=barrierWidth, ratio=sizeRatio);
    barrierOuterPosition = getCurveOuterBarrierPosition(length=length, width=width, barrierWidth=barrierWidth, ratio=sizeRatio);
    innerBarrierChunks = getCurveInnerBarrierChunks(barrierChunks, ratio);
    outerBarrierChunks = getCurveOuterBarrierChunks(barrierChunks, ratio);

    centerX = (outerRadius - cos(angle) * innerRadius) / 2 - outerRadius;
    centerY = -(sin(angle) * outerRadius) / 2;

    module maleLink() {
        barrierLinkGround(
            width = barrierWidth,
            height = barrierHeight,
            thickness = thickness
        );
    }

    module femaleLink() {
        barrierLinkGroundHole(
            width = barrierWidth,
            height = barrierHeight
        );
    }

    translate([centerX, centerY, 0]) {
        difference() {
            // Tile body
            curvedGround(
                length = length,
                width = width,
                thickness = thickness,
                angle = angle,
                ratio = sizeRatio
            );
            // Fastener holes
            curvedGroundHoles(
                radius = barrierInnerPosition,
                angle = angle,
                thickness = thickness,
                barrierWidth = barrierWidth,
                barrierHeight = barrierHeight,
                barrierChunks = innerBarrierChunks
            );
            curvedGroundHoles(
                radius = barrierOuterPosition,
                angle = angle,
                thickness = thickness,
                barrierWidth = barrierWidth,
                barrierHeight = barrierHeight,
                barrierChunks = outerBarrierChunks
            );
            // Barrier link holes
            translate([barrierOuterPosition, 0, -barrierHeight / 2]) {
                rotateZ(-CURVE_ANGLE) {
                    femaleLink();
                }
            }
            rotateZ(angle) {
                translate([barrierInnerPosition, 0, -barrierHeight / 2]) {
                    rotateZ(CURVE_ANGLE) {
                        femaleLink();
                    }
                }
            }
        }
        // Barrier links
        translateX(barrierInnerPosition) {
            rotateZ(-CURVE_ANGLE) {
                maleLink();
            }
        }
        rotateZ(angle) {
            translateX(barrierOuterPosition) {
                rotateZ(CURVE_ANGLE) {
                    maleLink();
                }
            }
        }
    }
}

/**
 * Draws the shape of an enlarged curve ground tile.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number thickness - The thickness of the track ground.
 * @param Number barrierWidth - The width of the barrier.
 * @param Number barrierHeight - The height of the barrier.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 */
module enlargedCurveGroundTile(length, width, thickness, barrierWidth, barrierHeight, barrierChunks, ratio=1) {
    angle = CURVE_ANGLE;
    side = getEnlargedCurveSide(length=length, width=width, ratio=ratio);
    sideOffset = side / 2;
    innerRadius = getCurveInnerRadius(length=length, width=width, ratio=ratio);
    outerRadius = getCurveOuterRadius(length=length, width=width, ratio=ratio);
    barrierSidePosition = getEnlargedCurveSideBarrierPosition(length=length, width=width, barrierWidth=barrierWidth, ratio=ratio) - sideOffset;
    barrierInnerPosition = getEnlargedCurveInnerBarrierPosition(length=length, width=width, barrierWidth=barrierWidth, ratio=ratio);
    barrierOuterPosition = getEnlargedCurveOuterBarrierPosition(length=length, width=width, barrierWidth=barrierWidth, ratio=ratio);
    sideBarrierChunks = getEnlargedCurveSideBarrierChunks(barrierChunks, ratio);
    innerBarrierChunks = getEnlargedCurveInnerBarrierChunks(barrierChunks, ratio);
    outerBarrierChunks = getEnlargedCurveOuterBarrierChunks(barrierChunks, ratio);

    module maleLink() {
        barrierLinkGround(
            width = barrierWidth,
            height = barrierHeight,
            thickness = thickness
        );
    }

    module femaleLink() {
        barrierLinkGroundHole(
            width = barrierWidth,
            height = barrierHeight
        );
    }

    translate([-outerRadius, -outerRadius, 0] / 2) {
        difference() {
            // Tile body
            enlargedCurveGround(
                length = length,
                width = width,
                thickness = thickness,
                ratio = ratio
            );
            // Fastener holes
            translate([sideOffset, sideOffset, 0]) {
                repeatRotate(count=2, angle=-CURVE_ANGLE) {
                    translateY(barrierSidePosition) {
                        straightGroundHolesLine(
                            length = side,
                            thickness = thickness,
                            barrierWidth = barrierWidth,
                            barrierHeight = barrierHeight,
                            barrierChunks = sideBarrierChunks
                        );
                    }
                }
            }
            curvedGroundHoles(
                radius = barrierInnerPosition,
                angle = angle,
                thickness = thickness,
                barrierWidth = barrierWidth,
                barrierHeight = barrierHeight,
                barrierChunks = innerBarrierChunks
            );
            translate([side, side, 0]) {
                curvedGroundHoles(
                    radius = barrierOuterPosition,
                    angle = angle,
                    thickness = thickness,
                    barrierWidth = barrierWidth,
                    barrierHeight = barrierHeight,
                    barrierChunks = outerBarrierChunks
                );
            }
            // Barrier link holes
            translate([side + barrierOuterPosition, 0, -barrierHeight / 2]) {
                rotateZ(-CURVE_ANGLE) {
                    femaleLink();
                }
            }
            rotateZ(angle) {
                translate([barrierInnerPosition, 0, -barrierHeight / 2]) {
                    rotateZ(CURVE_ANGLE) {
                        femaleLink();
                    }
                }
            }
        }
        // Barrier links
        translateX(barrierInnerPosition) {
            rotateZ(-CURVE_ANGLE) {
                maleLink();
            }
        }
        rotateZ(angle) {
            translateX(side + barrierOuterPosition) {
                rotateZ(CURVE_ANGLE) {
                    maleLink();
                }
            }
        }
    }
}
