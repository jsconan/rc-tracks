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
 * Adjusts the position on the print plat to either print as it or to flip upside down the model.
 * @param Boolean flip - Flip upside down the element.
 */
module flipElement(flip=false) {
    rotate(flip ? [180, 0, 180] : [0, 0, 0]) {
        children();
    }
}

/**
 * Repeats and place a shape on a grid with respect to the expected quantity.
 * @param Number length - The length of the shape.
 * @param Number width - The width of the shape.
 * @param Number [quantity] - The number of elements to print, it will be rounded to by its square root.
 */
module placeElements(length, width, quantity=1) {
    line = ceil(sqrt(quantity));
    rest = ceil(quantity / line);

    repeat2D(
        intervalX = [getPrintInterval(length), 0, 0],
        intervalY = [0, getPrintInterval(width), 0],
        countX = length > width ? rest : line,
        countY = length > width ? line : rest,
        center = true
    ) {
        children();
    }
}

/**
 * A set of pegs to fasten the barrier chunks to the track sections.
 * @param Number [quantity] - The number of elements to print, it will be rounded to by its square root.
 */
module barrierPegsSet(quantity=1) {
    radius = getBarrierPegDiameter(barrierWidth, barrierHeight) + trackGroundThickness * 2;

    placeElements(length=radius, width=radius, quantity=quantity) {
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
 * @param Number [quantity] - The number of elements to print.
 */
module straightBarriersSet(quantity=1) {
    length = getStraightBarrierMaleLength(barrierLength, barrierWidth, barrierHeight);
    width = getPrintInterval(barrierWidth * 2);
    interval = getPrintInterval(barrierWidth) / 2;

    placeElements(length=length, width=width, quantity=quantity) {
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
}

/**
 * A set of barrier chunks for the inner curve of a curved track section, with male and female variants.
 * @param Number [ratio] - The size factor.
  * @param Number [quantity] - The number of elements to print.
 */
module innerCurveBarriersSet(ratio=1, quantity=1) {
    radius = getCurveInnerBarrierPosition(trackSectionLength, trackSectionWidth, barrierWidth, ratio);
    angle = getCurveAngle(ratio) / getCurveInnerBarrierChunks(barrierChunks, ratio);
    length = getCurvedBarrierMaleLength(radius, angle, barrierWidth, barrierHeight);
    width = getPrintInterval(barrierWidth * 2);
    interval = getPrintInterval(barrierWidth) / 2;

    placeElements(length=length, width=width, quantity=quantity) {
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
}

/**
 * A set of barrier chunks for the outer curve of a curved track section, with male and female variants.
 * @param Number [ratio] - The size factor.
 * @param Number [quantity] - The number of elements to print.
 */
module outerCurveBarriersSet(ratio=1, quantity=1) {
    radius = getCurveOuterBarrierPosition(trackSectionLength, trackSectionWidth, barrierWidth, ratio);
    angle = getCurveAngle(ratio) / getCurveOuterBarrierChunks(barrierChunks, ratio);
    length = getCurvedBarrierMaleLength(radius, angle, barrierWidth, barrierHeight);
    width = getPrintInterval(barrierWidth * 2);
    interval = getPrintInterval(barrierWidth) / 2;

    placeElements(length=length, width=width, quantity=quantity) {
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
}

/**
 * A set of barrier chunks for the outer curve of an enlarged curved track section, with male and female variants.
 * @param Number [ratio] - The size factor.
 * @param Number [quantity] - The number of elements to print.
 */
module enlargedCurveBarriersSet(ratio=1, quantity=1) {
    radius = getEnlargedCurveOuterBarrierPosition(trackSectionLength, trackSectionWidth, barrierWidth, ratio);
    angle = getCurveAngle(ratio) / getEnlargedCurveOuterBarrierChunks(barrierChunks, ratio);
    length = getCurvedBarrierMaleLength(radius, angle, barrierWidth, barrierHeight);
    width = getPrintInterval(barrierWidth * 2);
    interval = getPrintInterval(barrierWidth) / 2;

    placeElements(length=length, width=width, quantity=quantity) {
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
