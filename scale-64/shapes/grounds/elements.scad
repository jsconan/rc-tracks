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
 * Defines the ready to print shapes for the ground tiles.
 *
 * @author jsconan
 */

/**
 * A ground tile of a straight track section.
 * @param Number [ratio] - The size factor.
 */
module straightTrackSectionGround(ratio=1) {
    translateZ(trackGroundThickness / 2) {
        flipElement(printGroundUpsideDown) {
            color(colorGround) {
                straightGroundTile(
                    length = trackSectionLength,
                    width = trackSectionWidth,
                    thickness = trackGroundThickness,
                    barrierWidth = barrierWidth,
                    barrierHeight = barrierHeight,
                    barrierChunks = barrierChunks,
                    ratio = ratio
                );
            }
        }
    }
}

/**
 * A ground tile of a starting track section.
 */
module startingTrackSectionGround() {
    translateZ(trackGroundThickness / 2) {
        color(colorGround) {
            straightGroundTile(
                length = trackSectionLength,
                width = trackSectionWidth,
                thickness = trackGroundThickness,
                barrierWidth = barrierWidth,
                barrierHeight = barrierHeight,
                barrierChunks = barrierChunks,
                ratio = 1
            );
        }
        translateZ((trackGroundThickness + layerHeight) / 2) {
            color(colorDecoration) {
                startingGroundTileDecoration(
                    length = trackSectionLength,
                    width = trackSectionWidth,
                    thickness = layerHeight,
                    barrierWidth = barrierWidth,
                    barrierHeight = barrierHeight,
                    startPositions = startPositions,
                    startLines = startLines,
                    shiftPositions = shiftStartPositions
                );
            }
        }
    }
}

/**
 * A ground tile of a curved track section.
 * @param Number [ratio] - The size factor.
 */
module curvedTrackSectionGround(ratio=1) {
    translateZ(trackGroundThickness / 2) {
        flipElement(printGroundUpsideDown) {
            color(colorGround) {
                curvedGroundTile(
                    length = trackSectionLength,
                    width = trackSectionWidth,
                    thickness = trackGroundThickness,
                    barrierWidth = barrierWidth,
                    barrierHeight = barrierHeight,
                    barrierChunks = barrierChunks,
                    ratio = ratio
                );
            }
        }
    }
}

/**
 * A ground tile of a curved track section with extra space.
 * @param Number [ratio] - The size factor.
 */
module enlargedCurveTrackSectionGround(ratio=1) {
    translateZ(trackGroundThickness / 2) {
        flipElement(printGroundUpsideDown) {
            color(colorGround) {
                enlargedCurveGroundTile(
                    length = trackSectionLength,
                    width = trackSectionWidth,
                    thickness = trackGroundThickness,
                    barrierWidth = barrierWidth,
                    barrierHeight = barrierHeight,
                    barrierChunks = barrierChunks,
                    ratio = ratio
                );
            }
        }
    }
}

/**
 * A ground tile and set of barrier chunks for a straight track section.
 * @param Number [ratio] - The size factor.
 */
 module straightTrackSectionSet(ratio=1) {
    pegsQuantity = getStraightBarrierChunks(barrierChunks, ratio) * 2;

    straightTrackSectionGround(ratio=ratio);
    translateY(-getPrintInterval(trackSectionWidth / 2)) {
        barrierPegSet(quantity=pegsQuantity, line=pegsQuantity);
    }
 }

/**
 * A ground tile and set of barrier chunks for a starting track section.
 */
 module startingTrackSectionSet() {
    pegsQuantity = getStraightBarrierChunks(barrierChunks, 1) * 2;

    startingTrackSectionGround();
    translateY(-getPrintInterval(trackSectionWidth / 2)) {
        barrierPegSet(quantity=pegsQuantity, line=pegsQuantity);
    }
 }

 /**
 * A ground tile and set of barrier chunks for a curved track section.
 * @param Number [ratio] - The size factor.
 */
 module curvedTrackSectionSet(ratio=1) {
    angle = getCurveAngle(ratio);
    innerBarrierChunks = getCurveInnerBarrierChunks(barrierChunks, ratio);
    outerBarrierChunks = getCurveOuterBarrierChunks(barrierChunks, ratio);
    center = getRawCurveCenter(length=trackSectionLength, width=trackSectionWidth, ratio=ratio);
    pegsQuantity = innerBarrierChunks + outerBarrierChunks;
    pegWidth = getBarrierPegDiameter(barrierWidth, barrierHeight) + trackGroundThickness * 2;

    curvedTrackSectionGround(ratio=ratio);
    rotate(printGroundUpsideDown ? angle : 180 - angle) {
        translateX(-(center.y + pegWidth)) {
            barrierPegSet(quantity=pegsQuantity, line=1);
        }
    }
 }

 /**
 * A ground tile and set of barrier chunks for a curved track section with extra space..
 * @param Number [ratio] - The size factor.
 */
 module enlargedCurveTrackSectionSet(ratio=1) {
    sideBarrierChunks = getEnlargedCurveSideBarrierChunks(barrierChunks, ratio);
    innerBarrierChunks = getEnlargedCurveInnerBarrierChunks(barrierChunks, ratio);
    outerBarrierChunks = getEnlargedCurveOuterBarrierChunks(barrierChunks, ratio);
    center = getRawEnlargedCurveCenter(length=trackSectionLength, width=trackSectionWidth, ratio=ratio);
    pegsQuantity = sideBarrierChunks * 2 + innerBarrierChunks + outerBarrierChunks;

    enlargedCurveTrackSectionGround(ratio=ratio);
    translateY(-getPrintInterval(center.y)) {
        barrierPegSet(quantity=pegsQuantity, line=pegsQuantity);
    }
 }
