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
 * Defines the ready to print shapes for the barriers.
 *
 * @author jsconan
 */

/**
 * A set of pegs to fasten the barrier chunks to the track sections.
 * @param Number [quantity] - The number of elements to print.
 * @param Number [line] - The max number of elements per lines.
 */
module barrierPegSet(quantity=1, line=undef) {
    radius = getBarrierPegDiameter(barrierWidth, barrierHeight) + trackGroundThickness * 2;
    pegHeight = getBarrierPegHeight(barrierWidth, barrierHeight, trackGroundThickness);

    placeElements(length=radius, width=radius, quantity=quantity, line=line) {
        translateZ(pegHeight / 2) {
            color(colorPeg) {
                barrierPeg(
                    width = barrierWidth,
                    height = barrierHeight,
                    diameter = fastenerDiameter,
                    thickness = trackGroundThickness,
                    distance = 0
                );
            }
        }
    }
}

/**
 * A set of barrier chunks for a straight track section.
 * @param Number [quantity] - The number of elements to print.
 * @param Number [line] - The max number of elements per lines.
 */
module straightBarrierSet(quantity=1, line=undef) {
    length = getStraightBarrierLength(barrierLength, barrierWidth, barrierHeight);

    placeElements(length=length, width=barrierWidth, quantity=quantity, line=line) {
        translateZ(barrierHeight / 2) {
            color(colorBarrier) {
                straightBarrier(
                    length = barrierLength,
                    width = barrierWidth,
                    height = barrierHeight,
                    diameter = fastenerDiameter,
                    headDiameter = fastenerHeadDiameter,
                    headHeight = fastenerHeadHeight
                );
            }
        }
    }
}

/**
 * A set of barrier chunks for the inner curve of a curved track section.
 * @param Number [ratio] - The size factor.
  * @param Number [quantity] - The number of elements to print.
  * @param Number [line] - The max number of elements per lines.
 */
module innerCurveBarrierSet(ratio=1, quantity=1, line=undef) {
    radius = getCurveInnerBarrierPosition(trackSectionLength, trackSectionWidth, barrierWidth, ratio);
    angle = getCurveAngle(ratio) / getCurveInnerBarrierChunks(barrierChunks, ratio);
    length = getCurvedBarrierLength(radius, angle, barrierWidth, barrierHeight);

    placeElements(length=length, width=barrierWidth, quantity=quantity, line=line) {
        translateZ(barrierHeight / 2) {
            color(colorBarrier) {
                curvedBarrier(
                    radius = radius,
                    angle = angle,
                    width = barrierWidth,
                    height = barrierHeight,
                    diameter = fastenerDiameter,
                    headDiameter = fastenerHeadDiameter,
                    headHeight = fastenerHeadHeight,
                    right = true
                );
            }
        }
    }
}

/**
 * A set of barrier chunks for the outer curve of a curved track section.
 * @param Number [ratio] - The size factor.
 * @param Number [quantity] - The number of elements to print.
 * @param Number [line] - The max number of elements per lines.
 */
module outerCurveBarrierSet(ratio=1, quantity=1, line=undef) {
    radius = getCurveOuterBarrierPosition(trackSectionLength, trackSectionWidth, barrierWidth, ratio);
    angle = getCurveAngle(ratio) / getCurveOuterBarrierChunks(barrierChunks, ratio);
    length = getCurvedBarrierLength(radius, angle, barrierWidth, barrierHeight);

    placeElements(length=length, width=barrierWidth, quantity=quantity, line=line) {
        translateZ(barrierHeight / 2) {
            color(colorBarrier) {
                curvedBarrier(
                    radius = radius,
                    angle = angle,
                    width = barrierWidth,
                    height = barrierHeight,
                    diameter = fastenerDiameter,
                    headDiameter = fastenerHeadDiameter,
                    headHeight = fastenerHeadHeight,
                    right = false
                );
            }
        }
    }
}

/**
 * A set of barrier chunks for the outer curve of an enlarged curved track section.
 * @param Number [ratio] - The size factor.
 * @param Number [quantity] - The number of elements to print.
 * @param Number [line] - The max number of elements per lines.
 */
module enlargedCurveBarrierSet(ratio=1, quantity=1, line=undef) {
    radius = getEnlargedCurveOuterBarrierPosition(trackSectionLength, trackSectionWidth, barrierWidth, ratio);
    angle = getCurveAngle(ratio) / getEnlargedCurveOuterBarrierChunks(barrierChunks, ratio);
    length = getCurvedBarrierLength(radius, angle, barrierWidth, barrierHeight);

    placeElements(length=length, width=barrierWidth, quantity=quantity, line=line) {
        translateZ(barrierHeight / 2) {
            color(colorBarrier) {
                curvedBarrier(
                    radius = radius,
                    angle = angle,
                    width = barrierWidth,
                    height = barrierHeight,
                    diameter = fastenerDiameter,
                    headDiameter = fastenerHeadDiameter,
                    headHeight = fastenerHeadHeight,
                    right = false
                );
            }
        }
    }
}
