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
 * Defines the track ground parts.
 *
 * @author jsconan
 */

/**
 * Draws the shape for a line of holes.
 * @param Number length - The length of a track section.
 * @param Number thickness - The thickness of the track ground.
 * @param Number barrierWidth - The width of the barrier.
 * @param Number barrierHeight - The height of the barrier.
 * @param Number barrierChunks - The number of barrier chunks per section.
 */
module straightGroundHolesLine(length, thickness, barrierWidth, barrierHeight, barrierChunks) {
    barrierLength = length / barrierChunks;

    repeat(intervalX=barrierLength, count=barrierChunks, center=true) {
        barrierPegHole(
            width = barrierWidth,
            height = barrierHeight,
            thickness = thickness,
            distance = printTolerance
        );
    }
}

/**
 * Draws the shape of the holes for a straight ground.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number thickness - The thickness of the track ground.
 * @param Number barrierWidth - The width of the barrier.
 * @param Number barrierHeight - The height of the barrier.
 * @param Number barrierChunks - The number of barrier chunks per section.
 */
module straightGroundHoles(length, width, thickness, barrierWidth, barrierHeight, barrierChunks) {
    barrierPosition = (width - barrierWidth) / 2;

    repeatRotate(count=2) {
        translateY(barrierPosition) {
            straightGroundHolesLine(
                length = length,
                thickness = thickness,
                barrierWidth = barrierWidth,
                barrierHeight = barrierHeight,
                barrierChunks = barrierChunks
            );
        }
    }
}

/**
 * Draws the shape of the link hole for a ground tile.
 * @param Number barrierWidth - The width of the barrier.
 * @param Number barrierHeight - The height of the barrier.
 */
module barrierLinkGroundHole(width, height) {
    barrierLink(
        width = width,
        height = height,
        distance = printTolerance * 2,
        neckDistance = 0
    );
}

/**
 * Draws the shape of the link for a ground tile.
 * @param Number barrierWidth - The width of the barrier.
 * @param Number barrierHeight - The height of the barrier.
 * @param Number thickness - The thickness of the link.
 */
module barrierLinkGround(width, height, thickness) {
    rotateZ(STRAIGHT) {
        linear_extrude(height=thickness, center=true, convexity=10) {
            barrierLinkProfile(
                width = width,
                height = height,
                distance = 0,
                neckDistance = 0
            );
        }
    }
}

/**
 * Draws the shape of a straight ground tile.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number thickness - The thickness of the track ground.
 * @param Number barrierWidth - The width of the barrier.
 * @param Number barrierHeight - The height of the barrier.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 */
module straightGroundTile(length, width, thickness, barrierWidth, barrierHeight, barrierChunks, ratio=1) {
    overallLength = getStraightLength(length, ratio);
    overallChunks = getStraightBarrierChunks(barrierChunks, ratio);

    difference() {
        // Tile body
        box([overallLength, width, thickness], center=true);
        // Fastener holes
        straightGroundHoles(
            length = overallLength,
            width = width,
            thickness = thickness,
            barrierWidth = barrierWidth,
            barrierHeight = barrierHeight,
            barrierChunks = overallChunks
        );
        // Barrier link holes
        repeatRotate(count=2) {
            translate([overallLength, width - barrierWidth, -barrierHeight] / 2) {
                barrierLinkGroundHole(
                    width = barrierWidth,
                    height = barrierHeight
                );
            }
        }
    }
    // Barrier links
    repeatRotate(count=2) {
        translate([overallLength, barrierWidth - width, 0] / 2) {
            barrierLinkGround(
                width = barrierWidth,
                height = barrierHeight,
                thickness = thickness
            );
        }
    }
}

/**
 * Draws the shape of the decoration for a starting ground tile.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number thickness - The thickness of the track ground.
 * @param Number barrierWidth - The width of the barrier.
 * @param Number barrierHeight - The height of the barrier.
 * @param Number startPositions - The number of parallel starting blocks.
 * @param Number startLines - The number of starting lines.
 */
module startingGroundTileDecoration(length, width, thickness, barrierWidth, barrierHeight, startPositions=3, startLines=2) {
    // Prepare the parameters
    laneWidth = getTrackLaneWidth(length, width);
    finishLineWidth = laneWidth / 10;
    finishLineArea = finishLineWidth * 2;
    finishLinePosition = length / 2;
    startingArea = length - finishLineArea;
    startingBlockLength = laneWidth / (startPositions + 1);
    startingBlockWidth = laneWidth / 10;
    startingBlockThickness = getBarrierBaseUnit(barrierWidth, barrierHeight);
    startingBlockIntervalX = laneWidth / startPositions;
    startingBlockIntervalY = startingArea / startLines;
    startingBlockShift = startingBlockWidth;
    startingBlockPosition = length / 2 + startingArea - length;

    // Uncomment to debug:
    // %rectangle([length, width]);
    // %translateX((startingArea - length) / 2) rectangle([startingArea, laneWidth]);
    // %translateX((length - finishLineArea) / 2) rectangle([finishLineArea, laneWidth]);

    // Render the finish line
    translateX(finishLinePosition) {
        rotateZ(-RIGHT) {
            finishLine(
                length = laneWidth,
                width = finishLineWidth,
                height = thickness,
                lines = 2,
                distance = 0,
                center = true
            );
        }
    }

    // Render the starting blocks
    translateX(startingBlockPosition) {
        rotateZ(-RIGHT) {
            repeat(count=startLines, interval=yAxis3D(-startingBlockIntervalY), center=false) {
                translateY(-startingBlockShift * (floor(startPositions / 2) - (1 - startPositions % 2) * .5)) {
                    repeat(count=startPositions, interval=[startingBlockIntervalX, -startingBlockShift, 0], center=true) {
                        startingBlock(
                            length = startingBlockLength,
                            width = startingBlockWidth,
                            height = thickness,
                            thickness = startingBlockThickness,
                            distance = 0,
                            center = true
                        );
                    }
                }
            }
        }
    }
}

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
module largeCurveGround(length, width, thickness, ratio=1) {
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

    translate([-innerRadius - (outerRadius - innerRadius) / 2, -length / 2, 0]) {
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

    translate([-innerRadius - (outerRadius - innerRadius) / 2, -length / 2, 0]) {
        difference() {
            // Tile body
            largeCurveGround(
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
