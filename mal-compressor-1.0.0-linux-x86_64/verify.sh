#!/bin/bash
# MAL Compressor - Easy verification script

# Check if mal executable exists
if [ ! -f "./mal" ] && [ ! -f "./mal.exe" ]; then
    echo "Error: mal executable not found!"
    echo "Please run 'build.sh' first to compile the project."
    exit 1
fi

# Determine executable name
if [ -f "./mal" ]; then
    MAL="./mal"
else
    MAL="./mal.exe"
fi

# Show help if no arguments
if [ $# -eq 0 ]; then
    echo "MAL Compressor - Verification Script"
    echo ""
    echo "Usage: ./verify.sh <archive.mal>"
    echo ""
    echo "Example:"
    echo "  ./verify.sh archive.mal"
    echo ""
    echo "This will verify the integrity of all files in the archive"
    echo "using CRC32 checksums."
    echo ""
    exit 0
fi

# Run verification
$MAL verify "$1"