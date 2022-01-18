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
 * Defines the ready to print track parts.
 *
 * @author jsconan
 */

/**
 * Adjust the position on the print plat to either print as it or to flip upside down the model.
 * @param Boolean flip - Flip upside down the element.
 */
module flipElement(flip = false) {
    rotate(flip ? [180, 0, 180] : [0, 0, 0]) {
        children();
    }
}

/**
 * A set of pegs to fasten the barrier chunks to the track sections.
 * @param Number quantity - The number of elements to print, it will be rounded to by the square root.
 */
module barrierPegsSet(quantity = barrierChunks) {
    interval = getPrintInterval(getBarrierPegDiameter(barrierWidth, barrierHeight));
    countX = ceil(sqrt(quantity));
    countY = ceil(quantity / countX);

    repeat2D(
        intervalX = [interval, 0, 0],
        intervalY = [0, interval, 0],
        countX = countX,
        countY = countY,
        center = true
    ) {
        barrierPeg(
            width = barrierWidth,
            height = barrierHeight,
            diameter = fastenerDiameter,
            thickness = trackGroundThickness,
            distance = 0
        );
    }
}

/**
 * A set of barrier chunks for a straight track section, with male and female variants.
 */
module straightBarriersSet() {
    interval = getPrintInterval(barrierWidth) / 2;

    translateY(-interval) {
        straightBarrierMale(
            length = barrierLength,
            width = barrierWidth,
            height = barrierHeight,
            diameter = fastenerDiameter,
            headDiameter = fastenerHeadDiameter,
            headHeight = fastenerHeadHeight
        );
    }

    translateY(interval) {
        straightBarrierFemale(
            length = barrierLength,
            width = barrierWidth,
            height = barrierHeight,
            diameter = fastenerDiameter,
            headDiameter = fastenerHeadDiameter,
            headHeight = fastenerHeadHeight
        );
    }
}

/**
 * A set of barrier chunks for the inner curve of a curved track section, with male and female variants.
 * @param Number [ratio] - The size factor.
 */
module innerCurveBarriersSet(ratio=1) {
    radius = getCurveInnerBarrierPosition(trackSectionLength, trackSectionWidth, barrierWidth, ratio);
    angle = getCurveAngle(ratio) / getCurveInnerBarrierChunks(barrierChunks, ratio);
    interval = getPrintInterval(barrierWidth) / 2;

    translateY(-interval) {
        curvedBarrierMale(
            radius = radius,
            angle = angle,
            width = barrierWidth,
            height = barrierHeight,
            diameter = fastenerDiameter,
            headDiameter = fastenerHeadDiameter,
            headHeight = fastenerHeadHeight
        );
    }

    translateY(interval) {
        curvedBarrierFemale(
            radius = radius,
            angle = angle,
            width = barrierWidth,
            height = barrierHeight,
            diameter = fastenerDiameter,
            headDiameter = fastenerHeadDiameter,
            headHeight = fastenerHeadHeight
        );
    }
}

/**
 * A set of barrier chunks for the outer curve of a curved track section, with male and female variants.
 * @param Number [ratio] - The size factor.
 */
module outerCurveBarriersSet(ratio=1) {
    radius = getCurveOuterBarrierPosition(trackSectionLength, trackSectionWidth, barrierWidth, ratio);
    angle = getCurveAngle(ratio) / getCurveOuterBarrierChunks(barrierChunks, ratio);
    interval = getPrintInterval(barrierWidth) / 2;

    translateY(-interval) {
        curvedBarrierMale(
            radius = radius,
            angle = angle,
            width = barrierWidth,
            height = barrierHeight,
            diameter = fastenerDiameter,
            headDiameter = fastenerHeadDiameter,
            headHeight = fastenerHeadHeight
        );
    }

    translateY(interval) {
        curvedBarrierFemale(
            radius = radius,
            angle = angle,
            width = barrierWidth,
            height = barrierHeight,
            diameter = fastenerDiameter,
            headDiameter = fastenerHeadDiameter,
            headHeight = fastenerHeadHeight
        );
    }
}

/**
 * A set of barrier chunks for the outer curve of an enlarged curved track section, with male and female variants.
 * @param Number [ratio] - The size factor.
 */
module enlargedCurveBarriersSet(ratio=1) {
    radius = getEnlargedCurveOuterBarrierPosition(trackSectionLength, trackSectionWidth, barrierWidth, ratio);
    angle = getCurveAngle(ratio) / getEnlargedCurveOuterBarrierChunks(barrierChunks, ratio);
    interval = getPrintInterval(barrierWidth) / 2;

    translateY(-interval) {
        curvedBarrierMale(
            radius = radius,
            angle = angle,
            width = barrierWidth,
            height = barrierHeight,
            diameter = fastenerDiameter,
            headDiameter = fastenerHeadDiameter,
            headHeight = fastenerHeadHeight
        );
    }

    translateY(interval) {
        curvedBarrierFemale(
            radius = radius,
            angle = angle,
            width = barrierWidth,
            height = barrierHeight,
            diameter = fastenerDiameter,
            headDiameter = fastenerHeadDiameter,
            headHeight = fastenerHeadHeight
        );
    }
}

/**
 * A ground tile of a straight track section.
 * @param Number [ratio] - The size factor.
 */
module straightTrackSectionGround(ratio=1) {
    flipElement(printGroundUpsideDown) {
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

/**
 * A ground tile of a tight curved track section.
 * @param Number [ratio] - The size factor.
 */
module curvedTrackSectionGround(ratio=1) {
    flipElement(printGroundUpsideDown) {
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

/**
 * A ground tile of a tight curved track section with extra space.
 * @param Number [ratio] - The size factor.
 */
module enlargedCurvedTrackSectionGround(ratio=1) {
    flipElement(printGroundUpsideDown) {
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
