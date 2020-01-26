/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2020 Jean-Sebastien CONAN
 *
 * This file is part of jsconan/things.
 *
 * jsconan/things is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * jsconan/things is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with jsconan/things. If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * A race track system for 1/24 to 1/32 scale RC cars.
 *
 * Defines the config.
 *
 * @author jsconan
 * @version 0.1.0
 */

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the constraints of the print.
printResolution = 0.2;      // The target layer height
nozzleWidth = 0.4;          // The size of the print nozzle
printTolerance = 0.1;       // The print tolerance when pieces need to be assembled

// Defines options
heightWithFasteners = true; // Should the height be with or without the fastener elements?

// The dimensions of a track chunk
chunkSize = 200;            // The nominal size of a chunk: the length for straight chunk, or the width for a curved chunk

// The constraints of the track barrier
barrierThickness = 0.6;     // The thickness of the barrier body
barrierHeight = 40;         // The height of the barrier, depending on the option heightWithFasteners
barrierHolderDepth = 6;     // The depth of the barrier holder to clamp the barrier body
barrierHolderBase = 2;      // The base value used to design the barrier holder
barrierNotchBase = 2;       // The base value used to design the barrier notches
