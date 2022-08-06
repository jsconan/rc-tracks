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
 * Defines the shapes for the curved full tiles.
 *
 * @author jsconan
 */

/**
 * Draws the shape of the holes for a curved tile.
 * @param Number radius - The radius of the curve at the position of the holes.
 * @param Number angle - The angle of the curve.
 * @param Number thickness - The thickness of the track ground.
 * @param Number barrierWidth - The width of the barrier.
 * @param Number barrierHeight - The height of the barrier.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number diameter - The diameter of the fasteners.
 * @param Number headDiameter - The diameter of the fasteners head.
 * @param Number headHeight - The height of the fasteners head.
 */
module curvedTileHoles(radius, angle, thickness, barrierWidth, barrierHeight, barrierChunks, diameter, headDiameter, headHeight) {
    holeSectorAngle = angle * (barrierChunks - 1) / barrierChunks;

    rotateZ((angle - holeSectorAngle) / 2) {
        repeatRotate(angle=holeSectorAngle, count=barrierChunks) {
            translateX(radius) {
                tileHole(
                    width = barrierWidth,
                    height = barrierHeight,
                    thickness = thickness,
                    diameter = diameter,
                    headDiameter = headDiameter,
                    headHeight = headHeight,
                    distance = printTolerance
                );
            }
        }
    }
}

/**
 * Draws the shape of a curved full tile.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number thickness - The thickness of the track ground.
 * @param Number barrierWidth - The width of the barrier.
 * @param Number barrierHeight - The height of the barrier.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number diameter - The diameter of the fasteners.
 * @param Number headDiameter - The diameter of the fasteners head.
 * @param Number headHeight - The height of the fasteners head.
 * @param Number [ratio] - The size factor.
 */
module curvedTile(length, width, thickness, barrierWidth, barrierHeight, barrierChunks, diameter, headDiameter, headHeight, ratio=1) {
    sizeRatio = max(1, ratio);
    angle = getCurveAngle(ratio);
    innerRadius = getCurveInnerRadius(length=length, width=width, ratio=sizeRatio);
    outerRadius = getCurveOuterRadius(length=length, width=width, ratio=sizeRatio);
    barrierInnerPosition = getCurveInnerBarrierPosition(length=length, width=width, barrierWidth=barrierWidth, ratio=sizeRatio);
    barrierOuterPosition = getCurveOuterBarrierPosition(length=length, width=width, barrierWidth=barrierWidth, ratio=sizeRatio);
    innerBarrierChunks = getCurveInnerBarrierChunks(barrierChunks, ratio);
    outerBarrierChunks = getCurveOuterBarrierChunks(barrierChunks, ratio);
    linkHeight = getBarrierLinkHeight(barrierWidth, barrierHeight);

    centerX = (outerRadius - cos(angle) * innerRadius) / 2 - outerRadius;
    centerY = -(sin(angle) * outerRadius) / 2;

    module maleLink() {
        tileLink(
            width = barrierWidth,
            height = linkHeight - layerHeight,
            thickness = thickness,
            distance = -printTolerance,
            neckDistance = printTolerance
        );
    }

    module femaleLink() {
        tileLink(
            width = barrierWidth,
            height = linkHeight + layerHeight,
            thickness = thickness + ALIGN,
            distance = printTolerance,
            neckDistance = 0
        );
    }

    translate([centerX, centerY, 0]) {
        difference() {
            union() {
                // Tile body
                translateZ(-thickness / 2) {
                    curvedGround(
                        length = length,
                        width = width,
                        thickness = thickness,
                        angle = angle,
                        ratio = sizeRatio
                    );
                }
                // Barriers body
                translateZ(barrierHeight / 2) {
                    curvedBarrierBody(
                        radius = barrierInnerPosition,
                        angle = angle,
                        width = barrierWidth,
                        height = barrierHeight
                    );
                    curvedBarrierBody(
                        radius = barrierOuterPosition,
                        angle = angle,
                        width = barrierWidth,
                        height = barrierHeight
                    );
                }
            }
            // Fastener holes
            curvedTileHoles(
                radius = barrierInnerPosition,
                angle = angle,
                thickness = thickness,
                barrierWidth = barrierWidth,
                barrierHeight = barrierHeight,
                barrierChunks = innerBarrierChunks,
                diameter = diameter,
                headDiameter = headDiameter,
                headHeight = headHeight,
            );
            curvedTileHoles(
                radius = barrierOuterPosition,
                angle = angle,
                thickness = thickness,
                barrierWidth = barrierWidth,
                barrierHeight = barrierHeight,
                barrierChunks = outerBarrierChunks,
                diameter = diameter,
                headDiameter = headDiameter,
                headHeight = headHeight,
            );
            // Barrier link holes
            translateX(barrierOuterPosition) {
                rotateZ(-CURVE_ANGLE) {
                    femaleLink();
                }
            }
            rotateZ(angle) {
                translateX(barrierInnerPosition) {
                    rotateZ(CURVE_ANGLE) {
                        femaleLink();
                    }
                }
            }
        }
        // Barrier links
        translateX(barrierInnerPosition) {
            rotateZ(CURVE_ANGLE) {
                maleLink();
            }
        }
        rotateZ(angle) {
            translateX(barrierOuterPosition) {
                rotateZ(-CURVE_ANGLE) {
                    maleLink();
                }
            }
        }
    }
}

/**
 * Draws the shape of an enlarged curve full tile.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number thickness - The thickness of the track ground.
 * @param Number barrierWidth - The width of the barrier.
 * @param Number barrierHeight - The height of the barrier.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number diameter - The diameter of the fasteners.
 * @param Number headDiameter - The diameter of the fasteners head.
 * @param Number headHeight - The height of the fasteners head.
 * @param Number [ratio] - The size factor.
 */
module enlargedCurveTile(length, width, thickness, barrierWidth, barrierHeight, barrierChunks, diameter, headDiameter, headHeight, ratio=1) {
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
    linkHeight = getBarrierLinkHeight(barrierWidth, barrierHeight);
    barrierLength = length / barrierChunks;

    module maleLink() {
        tileLink(
            width = barrierWidth,
            height = linkHeight - layerHeight,
            thickness = thickness,
            distance = -printTolerance,
            neckDistance = printTolerance
        );
    }

    module femaleLink() {
        tileLink(
            width = barrierWidth,
            height = linkHeight + layerHeight,
            thickness = thickness + ALIGN,
            distance = printTolerance,
            neckDistance = 0
        );
    }

    translate([-outerRadius, -outerRadius, 0] / 2) {
        difference() {
            union() {
                // Tile body
                translateZ(-thickness / 2) {
                    enlargedCurveGround(
                        length = length,
                        width = width,
                        thickness = thickness,
                        ratio = ratio
                    );
                }
                // Barriers body
                translateZ(barrierHeight / 2) {
                    curvedBarrierBody(
                        radius = barrierInnerPosition,
                        angle = angle,
                        width = barrierWidth,
                        height = barrierHeight
                    );
                    translate([side, side, 0]) {
                        curvedBarrierBody(
                            radius = barrierOuterPosition,
                            angle = angle,
                            width = barrierWidth,
                            height = barrierHeight
                        );
                    }
                    translate([sideOffset, sideOffset, 0]) {
                        repeatRotate(count=2, angle=-CURVE_ANGLE) {
                            translateY(barrierSidePosition) {
                                straightBarrierBody(
                                    length = side,
                                    width = barrierWidth,
                                    height = barrierHeight
                                );
                            }
                        }
                    }
                }
            }
            // Fastener holes
            curvedTileHoles(
                radius = barrierInnerPosition,
                angle = angle,
                thickness = thickness,
                barrierWidth = barrierWidth,
                barrierHeight = barrierHeight,
                barrierChunks = innerBarrierChunks,
                diameter = diameter,
                headDiameter = headDiameter,
                headHeight = headHeight,
            );
            translate([side, side, 0]) {
                curvedTileHoles(
                    radius = barrierOuterPosition,
                    angle = angle,
                    thickness = thickness,
                    barrierWidth = barrierWidth,
                    barrierHeight = barrierHeight,
                    barrierChunks = innerBarrierChunks,
                    diameter = diameter,
                    headDiameter = headDiameter,
                    headHeight = headHeight,
                );
            }
            translate([sideOffset, sideOffset, 0]) {
                repeatRotate(count=2, angle=-CURVE_ANGLE) {
                    translateY(barrierSidePosition) {
                        repeat(intervalX=barrierLength, count=sideBarrierChunks, center=true) {
                            tileHole(
                                width = barrierWidth,
                                height = barrierHeight,
                                thickness = thickness,
                                diameter = diameter,
                                headDiameter = headDiameter,
                                headHeight = headHeight,
                                distance = printTolerance
                            );
                        }
                    }
                }
            }
            // Barrier link holes
            translateX(side + barrierOuterPosition) {
                rotateZ(-CURVE_ANGLE) {
                    femaleLink();
                }
            }
            rotateZ(angle) {
                translateX(barrierInnerPosition) {
                    rotateZ(CURVE_ANGLE) {
                        femaleLink();
                    }
                }
            }
        }
        // Barrier links
        translateX(barrierInnerPosition) {
            rotateZ(CURVE_ANGLE) {
                maleLink();
            }
        }
        rotateZ(angle) {
            translateX(side + barrierOuterPosition) {
                rotateZ(-CURVE_ANGLE) {
                    maleLink();
                }
            }
        }
    }
}
