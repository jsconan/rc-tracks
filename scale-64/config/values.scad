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
 * Refines the configuration values.
 *
 * @author jsconan
 */

/**
 * Computes the overall width of a track section.
 * @param Number laneWidth - The width of a track lane.
 * @param Number barrierWidth - The width of the barriers.
 * @returns Number
 */
function getTrackSectionWidth(laneWidth, barrierWidth) = laneWidth + barrierWidth * 2;

/**
 * Computes the overall length of a track section.
 * @param Number laneWidth - The width of a track lane.
 * @param Number barrierWidth - The width of the barriers.
 * @returns Number
 */
function getTrackSectionLength(laneWidth, barrierWidth) = getTrackSectionWidth(laneWidth, barrierWidth) + laneWidth / 4;

/**
 * Computes the width of the track lane from the given track section length and width.
 * @param Number width - The width of a track section.
 * @param Number barrierWidth - The width of the barriers.
 * @returns Number
 */
function getTrackLaneWidth(width, barrierWidth) = width - barrierWidth * 2;

/**
 * Computes the length of a barrier chunk.
 * @param Number laneWidth - The width of a track lane.
 * @param Number barrierWidth - The width of the barriers.
 * @param Number barrierChunks - The number barriers per track section.
 * @returns Number
 */
function getBarrierLength(laneWidth, barrierWidth, barrierChunks) = getTrackSectionLength(laneWidth, barrierWidth) / barrierChunks;

/**
 * Computes the base unit value used to design the barrier shape.
 * @param Number width - The width of the barriers.
 * @param Number height - The height of the barriers.
 * @returns Number
 */
function getBarrierBaseUnit(width, height) = min(width, height) / 4;

/**
 * Computes the size of the offset for the barrier shape.
 * @param Number width - The width of the barriers.
 * @param Number height - The height of the barriers.
 * @returns Number
 */
function getBarrierOffset(width, height) = getBarrierBaseUnit(width, height) / 4;

/**
 * Computes the outer length of a barrier link.
 * @param Number width - The width of the barriers.
 * @param Number height - The height of the barriers.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 * @returns Number
 */
function getBarrierLinkLength(width, height, distance=0) = getBarrierBaseUnit(width, height) * 1.5 + distance;

/**
 * Computes the outer width of a barrier link.
 * @param Number width - The width of the barriers.
 * @param Number height - The height of the barriers.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 * @returns Number
 */
function getBarrierLinkWidth(width, height, distance=0) = (getBarrierBaseUnit(width, height) + distance) * 2;

/**
 * Computes the height of a barrier link.
 * @param Number width - The width of the barriers.
 * @param Number height - The height of the barriers.
 * @returns Number
 */
function getBarrierLinkHeight(width, height) = layerAligned(height - getBarrierBaseUnit(width, height));

/**
 * Computes the diameter of the barrier pegs.
 * @param Number width - The width of the barriers.
 * @param Number height - The height of the barriers.
 * @returns Number
 */
function getBarrierPegDiameter(width, height) = width - getBarrierBaseUnit(width, height) - shells(2);

/**
 * Computes the height of the barrier pegs that plugs into the barriers.
 * @param Number width - The width of the barriers.
 * @param Number height - The height of the barriers.
 * @returns Number
 */
function getBarrierPegInnerHeight(width, height) = layerAligned(getBarrierBaseUnit(width, height) * 1.5);

/**
 * Computes the overall height of the barrier pegs.
 * @param Number width - The width of the barriers.
 * @param Number height - The height of the barriers.
 * @param Number thickness - The thickness of the ground.
 * @returns Number
 */
function getBarrierPegHeight(width, height, thickness) = getBarrierPegInnerHeight(width, height) + thickness;

/**
 * Computes the angle of a curve with respect to the ratio.
 * @param Number ratio - The ratio of the curve.
 * @returns Number
 */
function getCurveAngle(ratio) =
    let(
        ratio = abs(ratio)
    )
    CURVE_ANGLE / (ratio < 1 ? 1 / ratio : ratio > 1 ? ratio * 2 : 1)
;

/**
 * Computes the inner radius of a curve given the ratio.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getCurveInnerRadius(length, width, ratio=1) = length * (ratio - 1) +  (length - width) / 2;

/**
 * Computes the outer radius of a curve given the ratio.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getCurveOuterRadius(length, width, ratio=1) = width + getCurveInnerRadius(length=length, width=width, ratio=ratio);

/**
 * Computes the length of the outer side of an enlarged curved track.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getEnlargedCurveSide(length, width, ratio=1) = length * ratio / 2;

/**
 * Computes the inner radius of a curve given the ratio.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getEnlargedCurveInnerRadius(length, width, ratio=1) = getCurveInnerRadius(length=length, width=width, ratio=ratio);

/**
 * Computes the outer radius of an enlarged curved track.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getEnlargedCurveOuterRadius(length, width, ratio=1) = getCurveOuterRadius(length=length, width=width, ratio=ratio) - getEnlargedCurveSide(length=length, width=width, ratio=ratio);

/**
 * Computes the position of the inner barrier of a curve given the ratio.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number barrierWidth - The width of the barriers.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getCurveInnerBarrierPosition(length, width, barrierWidth, ratio=1) = getCurveInnerRadius(length=length, width=width, ratio=ratio) + barrierWidth / 2;

/**
 * Computes the position of the outer barrier of a curve given the ratio.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number barrierWidth - The width of the barriers.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getCurveOuterBarrierPosition(length, width, barrierWidth, ratio=1) = getCurveOuterRadius(length=length, width=width, ratio=ratio) - barrierWidth / 2;

/**
 * Computes the position of the side barrier of an enlarged curve given the ratio.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number barrierWidth - The width of the barriers.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getEnlargedCurveSideBarrierPosition(length, width, barrierWidth, ratio=1) = getCurveOuterRadius(length=length, width=width, ratio=ratio) - barrierWidth / 2;

/**
 * Computes the position of the inner barrier of an enlarged curve given the ratio.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number barrierWidth - The width of the barriers.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getEnlargedCurveInnerBarrierPosition(length, width, barrierWidth, ratio=1) = getEnlargedCurveInnerRadius(length=length, width=width, ratio=ratio) + barrierWidth / 2;

/**
 * Computes the position of the outer barrier of an enlarged curve given the ratio.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number barrierWidth - The width of the barriers.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getEnlargedCurveOuterBarrierPosition(length, width, barrierWidth, ratio=1) = getEnlargedCurveOuterRadius(length=length, width=width, ratio=ratio) - barrierWidth / 2;

/**
 * Computes the number of barrier chunks for a straight section given the ratio.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getStraightBarrierChunks(barrierChunks, ratio=1) = barrierChunks * abs(ratio);

/**
 * Computes the number of barrier chunks for an inner curved section given the ratio.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getCurveInnerBarrierChunks(barrierChunks, ratio=1) = ratio < 1 ? 1 : barrierChunks / 2;

/**
 * Computes the number of barrier chunks for an outer curved section given the ratio.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getCurveOuterBarrierChunks(barrierChunks, ratio=1) = ratio == 1 ? barrierChunks : barrierChunks / 2;

/**
 * Computes the number of barrier chunks for the straight sides of large curve track.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getEnlargedCurveSideBarrierChunks(barrierChunks, ratio=1) = getStraightBarrierChunks(barrierChunks, ratio) / 2;

/**
 * Computes the number of barrier chunks for the inner curve of large curve track.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getEnlargedCurveInnerBarrierChunks(barrierChunks, ratio=1) = getCurveInnerBarrierChunks(barrierChunks, ratio) * ratio;

/**
 * Computes the number of barrier chunks for the outer curve of large curve track.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getEnlargedCurveOuterBarrierChunks(barrierChunks, ratio=1) = ratio == 1 ? barrierChunks / 2 : barrierChunks;

// The overall length of a track section (size of a tile in the track)
trackSectionLength = getTrackSectionLength(trackLaneWidth, barrierWidth);

// The overall width of a track section (size of a tile in the track)
trackSectionWidth = getTrackSectionWidth(trackLaneWidth, barrierWidth);

// The length of a barrier chunk
barrierLength = getBarrierLength(trackLaneWidth, barrierWidth, barrierChunks);

// The number of fastener holes per barrier chunks
FASTENER_HOLES = 1;

/**
 * Validates the config values, checking if it match the critical constraints.
 * @param Number lane - The width of the track lane (the distance between the barriers).
 * @param Number thickness - The thickness of a track tile (track ground).
 * @param Number width - The width of the barriers.
 * @param Number height - The height of the barriers.
 * @param Number chunks - The number of barrier chunks per section.
 * @param Number diameter - The diameter of the fasteners that can be used for the barriers.
 * @param Number headDiameter - The diameter of the fasteners head.
 * @param Number headHeight - The height of the fasteners head.
 */
module validateConfig(lane, thickness, width, height, chunks, diameter, headDiameter, headHeight) {
    assert(
        getBarrierLength(lane, width, chunks) > getBarrierLinkLength(width, height) * 2 + getBarrierPegDiameter(width, height) + shells(8),
        "The size of a barrier chunk is too small! Please increase the track lane or reduce the number of chunks per track section."
    );
    assert(
        !(chunks % 2),
        "The number of chunks per track section must be a factor of 2."
    );
    assert(
        width > diameter + getBarrierBaseUnit(width, height) * 2,
        "The diameter of the barrier fasteners is too large to fit into the barrier chunks!"
    );
    assert(
        width > headDiameter + getBarrierBaseUnit(width, height),
        "The diameter of the barrier fasteners head is too large to fit into the barrier chunks!"
    );
    assert(
        height > headHeight * 2 + getBarrierBaseUnit(width, height),
        "The height of the barrier fasteners head is too large to fit into the barrier chunks!"
    );
    assert(
        thickness > layers(2),
        "The ground thickness is too small, please increase it!"
    );
}

/**
 * Prints the config values.
 * @param Number lane - The width of the track lane (the distance between the barriers).
 * @param Number thickness - The thickness of a track tile (track ground).
 * @param Number width - The width of the barriers.
 * @param Number height - The height of the barriers.
 * @param Number chunks - The number of barrier chunks per section.
 * @param Number diameter - The diameter of the fasteners that can be used for the barriers.
 * @param Number headDiameter - The diameter of the fasteners head.
 * @param Number headHeight - The height of the fasteners head.
 */
module printConfig(lane, thickness, width, height, chunks, diameter, headDiameter, headHeight) {
    base = getBarrierBaseUnit(width, height);
    trackSectionLength = getTrackSectionLength(lane, width);
    trackSectionWidth = getTrackSectionWidth(lane, width);
    trackSectionPadding = (trackSectionLength - trackSectionWidth) / 2;
    barrierLength = getBarrierLength(lane, width, chunks);
    tightCurveInnerRadius = getCurveInnerRadius(trackSectionLength, trackSectionWidth, 1) + barrierWidth;
    tightCurveOuterRadius = getCurveOuterRadius(trackSectionLength, trackSectionWidth, 1) - barrierWidth;
    largeCurveInnerRadius = getCurveInnerRadius(trackSectionLength, trackSectionWidth, 2) + barrierWidth;
    largeCurveOuterRadius = getCurveOuterRadius(trackSectionLength, trackSectionWidth, 2) - barrierWidth;

    echo(join([
        "",
        str("-- RC Track System ------------------"),
        str("Version:                       ", projectVersion),
        str("Scale:                         ", "1/64 to 1/76"),
        str("-- Track elements -------------------"),
        str("Track lane width:              ", lane / 10, "cm"),
        str("Track section length:          ", trackSectionLength / 10, "cm"),
        str("Track section width:           ", trackSectionWidth / 10, "cm"),
        str("Track section padding:         ", trackSectionPadding / 10, "cm"),
        str("Tight curve inner radius:      ", tightCurveInnerRadius / 10, "cm"),
        str("Tight curve outer radius:      ", tightCurveOuterRadius / 10, "cm"),
        str("Large curve inner radius:      ", largeCurveInnerRadius / 10, "cm"),
        str("Large curve outer radius:      ", largeCurveOuterRadius / 10, "cm"),
        str("Barrier width:                 ", width, "mm"),
        str("Barrier height:                ", height, "mm"),
        str("Barrier length:                ", barrierLength, "mm"),
        str("Barrier chunks:                ", chunks, " per section"),
        str("Barrier base value:            ", base, "mm"),
        str("Barrier fastener diameter      ", diameter, "mm"),
        str("Barrier fastener head diameter ", headDiameter, "mm"),
        str("Barrier fastener head height   ", headHeight, "mm"),
        str("Ground thickness:              ", thickness, "mm"),
        str("-- Printer settings -----------------"),
        str("Nozzle diameter:               ", nozzleWidth, "mm"),
        str("Print layer:                   ", layerHeight, "mm"),
        str("Print tolerance:               ", printTolerance, "mm"),
        str("Printer's length:              ", printerLength / 10, "cm"),
        str("Printer's width:               ", printerWidth / 10, "cm"),
        str("Print interval:                ", printInterval, "mm"),
        ""
    ], str(chr(13), chr(10))));
}
