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
 * @param Number [quantity] - The number of elements to print.
 * @param Number [line] - The max number of elements per lines.
 */
module placeElements(length, width, quantity=1, line=undef) {
    repeatGrid(
        count = quantity,
        intervalX = xAxis3D(getPrintInterval(length)),
        intervalY = yAxis3D(getPrintInterval(width)),
        line = uor(line, ceil(sqrt(quantity))),
        center = true
    ) {
        children();
    }
}

/**
 * A set of pegs to fasten the barrier chunks to the track sections.
 * @param Number [quantity] - The number of elements to print.
 * @param Number [line] - The max number of elements per lines.
 */
module barrierPegsSet(quantity=1, line=undef) {
    radius = getBarrierPegDiameter(barrierWidth, barrierHeight) + trackGroundThickness * 2;

    placeElements(length=radius, width=radius, quantity=quantity, line=line) {
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
 * A set of barrier peg removers.
 * @param Number [quantity] - The number of elements to print.
 * @param Number [line] - The max number of elements per lines.
 */
module barrierPegRemoverSet(quantity=1, line=undef) {
    placeElements(length=barrierWidth, width=barrierWidth, quantity=quantity, line=line) {
        barrierPegRemover(
            diameter = fastenerDiameter,
            headDiameter = fastenerHeadDiameter,
            headHeight = fastenerHeadHeight,
            distance = 0
        );
    }
}

/**
 * A set of barrier peg extractors.
 * @param Number [quantity] - The number of elements to print.
 * @param Number [line] - The max number of elements per lines.
 */
module barrierPegExtractorSet(quantity=1, line=undef) {
    pegDiameter = getBarrierPegDiameter(barrierWidth, barrierHeight);
    width = pegDiameter * 5;
    length = width * 2;

    placeElements(length=length, width=width, quantity=quantity, line=line) {
        barrierPegExtractor(
            width = barrierWidth,
            height = barrierHeight,
            diameter = fastenerDiameter,
            thickness = trackGroundThickness,
            distance = printTolerance
        );
    }
}

/**
 * A set of barrier chunks for a straight track section, with male and female variants.
 * @param Number [quantity] - The number of elements to print.
 * @param Number [line] - The max number of elements per lines.
 */
module straightBarriersSet(quantity=1, line=undef) {
    length = getStraightBarrierMaleLength(barrierLength, barrierWidth, barrierHeight);
    width = getPrintInterval(barrierWidth * 2);
    interval = getPrintInterval(barrierWidth) / 2;

    placeElements(length=length, width=width, quantity=quantity, line=line) {
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
 * A set of male barrier chunks for a straight track section.
 * @param Number [quantity] - The number of elements to print.
 * @param Number [line] - The max number of elements per lines.
 */
module straightBarrierMaleSet(quantity=1, line=undef) {
    length = getStraightBarrierMaleLength(barrierLength, barrierWidth, barrierHeight);

    placeElements(length=length, width=barrierWidth, quantity=quantity, line=line) {
        straightBarrierMale(
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
 * A set of female barrier chunks for a straight track section.
 * @param Number [quantity] - The number of elements to print.
 * @param Number [line] - The max number of elements per lines.
 */
module straightBarrierFemaleSet(quantity=1, line=undef) {
    length = getStraightBarrierFemaleLength(barrierLength, barrierWidth, barrierHeight);

    placeElements(length=length, width=barrierWidth, quantity=quantity, line=line) {
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
  * @param Number [quantity] - The number of elements to print.
  * @param Number [line] - The max number of elements per lines.
 */
module innerCurveBarriersSet(ratio=1, quantity=1, line=undef) {
    radius = getCurveInnerBarrierPosition(trackSectionLength, trackSectionWidth, barrierWidth, ratio);
    angle = getCurveAngle(ratio) / getCurveInnerBarrierChunks(barrierChunks, ratio);
    length = getCurvedBarrierMaleLength(radius, angle, barrierWidth, barrierHeight);
    width = getPrintInterval(barrierWidth * 2);
    interval = getPrintInterval(barrierWidth) / 2;

    placeElements(length=length, width=width, quantity=quantity, line=line) {
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
 * A set of male barrier chunks for the inner curve of a curved track section.
 * @param Number [ratio] - The size factor.
  * @param Number [quantity] - The number of elements to print.
  * @param Number [line] - The max number of elements per lines.
 */
module innerCurveBarrierMaleSet(ratio=1, quantity=1, line=undef) {
    radius = getCurveInnerBarrierPosition(trackSectionLength, trackSectionWidth, barrierWidth, ratio);
    angle = getCurveAngle(ratio) / getCurveInnerBarrierChunks(barrierChunks, ratio);
    length = getCurvedBarrierMaleLength(radius, angle, barrierWidth, barrierHeight);

    placeElements(length=length, width=barrierWidth, quantity=quantity, line=line) {
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
}

/**
 * A set of female barrier chunks for the inner curve of a curved track section.
 * @param Number [ratio] - The size factor.
  * @param Number [quantity] - The number of elements to print.
  * @param Number [line] - The max number of elements per lines.
 */
module innerCurveBarrierFemaleSet(ratio=1, quantity=1, line=undef) {
    radius = getCurveInnerBarrierPosition(trackSectionLength, trackSectionWidth, barrierWidth, ratio);
    angle = getCurveAngle(ratio) / getCurveInnerBarrierChunks(barrierChunks, ratio);
    length = getCurvedBarrierFemaleLength(radius, angle, barrierWidth, barrierHeight);

    placeElements(length=length, width=barrierWidth, quantity=quantity, line=line) {
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
 * @param Number [quantity] - The number of elements to print.
 * @param Number [line] - The max number of elements per lines.
 */
module outerCurveBarriersSet(ratio=1, quantity=1, line=undef) {
    radius = getCurveOuterBarrierPosition(trackSectionLength, trackSectionWidth, barrierWidth, ratio);
    angle = getCurveAngle(ratio) / getCurveOuterBarrierChunks(barrierChunks, ratio);
    length = getCurvedBarrierMaleLength(radius, angle, barrierWidth, barrierHeight);
    width = getPrintInterval(barrierWidth * 2);
    interval = getPrintInterval(barrierWidth) / 2;

    placeElements(length=length, width=width, quantity=quantity, line=line) {
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
 * A set of male barrier chunks for the outer curve of a curved track section.
 * @param Number [ratio] - The size factor.
 * @param Number [quantity] - The number of elements to print.
 * @param Number [line] - The max number of elements per lines.
 */
module outerCurveBarrierMaleSet(ratio=1, quantity=1, line=undef) {
    radius = getCurveOuterBarrierPosition(trackSectionLength, trackSectionWidth, barrierWidth, ratio);
    angle = getCurveAngle(ratio) / getCurveOuterBarrierChunks(barrierChunks, ratio);
    length = getCurvedBarrierMaleLength(radius, angle, barrierWidth, barrierHeight);

    placeElements(length=length, width=barrierWidth, quantity=quantity, line=line) {
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
}

/**
 * A set of female barrier chunks for the outer curve of a curved track section.
 * @param Number [ratio] - The size factor.
 * @param Number [quantity] - The number of elements to print.
 * @param Number [line] - The max number of elements per lines.
 */
module outerCurveBarrierFemaleSet(ratio=1, quantity=1, line=undef) {
    radius = getCurveOuterBarrierPosition(trackSectionLength, trackSectionWidth, barrierWidth, ratio);
    angle = getCurveAngle(ratio) / getCurveOuterBarrierChunks(barrierChunks, ratio);
    length = getCurvedBarrierFemaleLength(radius, angle, barrierWidth, barrierHeight);

    placeElements(length=length, width=barrierWidth, quantity=quantity, line=line) {
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
 * @param Number [quantity] - The number of elements to print.
 * @param Number [line] - The max number of elements per lines.
 */
module enlargedCurveBarriersSet(ratio=1, quantity=1, line=undef) {
    radius = getEnlargedCurveOuterBarrierPosition(trackSectionLength, trackSectionWidth, barrierWidth, ratio);
    angle = getCurveAngle(ratio) / getEnlargedCurveOuterBarrierChunks(barrierChunks, ratio);
    length = getCurvedBarrierMaleLength(radius, angle, barrierWidth, barrierHeight);
    width = getPrintInterval(barrierWidth * 2);
    interval = getPrintInterval(barrierWidth) / 2;

    placeElements(length=length, width=width, quantity=quantity, line=line) {
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
 * A set of male barrier chunks for the outer curve of an enlarged curved track section.
 * @param Number [ratio] - The size factor.
 * @param Number [quantity] - The number of elements to print.
 * @param Number [line] - The max number of elements per lines.
 */
module enlargedCurveBarrierMaleSet(ratio=1, quantity=1, line=undef) {
    radius = getEnlargedCurveOuterBarrierPosition(trackSectionLength, trackSectionWidth, barrierWidth, ratio);
    angle = getCurveAngle(ratio) / getEnlargedCurveOuterBarrierChunks(barrierChunks, ratio);
    length = getCurvedBarrierMaleLength(radius, angle, barrierWidth, barrierHeight);

    placeElements(length=length, width=barrierWidth, quantity=quantity, line=line) {
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
}

/**
 * A set of female barrier chunks for the outer curve of an enlarged curved track section.
 * @param Number [ratio] - The size factor.
 * @param Number [quantity] - The number of elements to print.
 * @param Number [line] - The max number of elements per lines.
 */
module enlargedCurveBarrierFemaleSet(ratio=1, quantity=1, line=undef) {
    radius = getEnlargedCurveOuterBarrierPosition(trackSectionLength, trackSectionWidth, barrierWidth, ratio);
    angle = getCurveAngle(ratio) / getEnlargedCurveOuterBarrierChunks(barrierChunks, ratio);
    length = getCurvedBarrierFemaleLength(radius, angle, barrierWidth, barrierHeight);

    placeElements(length=length, width=barrierWidth, quantity=quantity, line=line) {
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
module enlargedCurveTrackSectionGround(ratio=1) {
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
