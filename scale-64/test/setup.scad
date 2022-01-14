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
 * Setup the context and define the config for the tests.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../config/setup.scad>

// Defines the test config
trackGroundThickness = .8;      // The thickness of a track tile (track ground)
trackLaneWidth = 120;           // The width of the track lane (the distance between the barriers)
barrierChunks = 4;              // The number of barrier chunks per section
barrierWidth = 6;               // The width of a barrier
barrierHeight = 8;              // The height of a barrier
fastenerDiameter = 2;           // The diameter of the fasteners that can be used for the barriers
fastenerHeadDiameter = 4;       // The diameter of the fasteners head
fastenerHeadHeight = 2;         // The height of the fasteners head

// The overall length of a track section (size of a tile in the track)
trackSectionLength = getTrackSectionLength(trackLaneWidth, barrierWidth);

// The overall width of a track section (size of a tile in the track)
trackSectionWidth = getTrackSectionWidth(trackLaneWidth, barrierWidth);

// The length of a barrier chunk
barrierLength = getBarrierLength(trackLaneWidth, barrierWidth, barrierChunks);
