#!/bin/bash
# MAL Compressor - Easy decompression script

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
    echo "MAL Compressor - Decompression Script"
    echo ""
    echo "Usage: ./decompress.sh <archive.mal> [options]"
    echo ""
    echo "Examples:"
    echo "  ./decompress.sh compressed/archive.mal         # Decompresses to decompressed/archive/"
    echo "  ./decompress.sh archive.mal -o custom/         # Decompresses to custom/"
    echo ""
    echo "Options:"
    echo "  -o <dir>  Custom output directory"
    echo "  -h        Show this help"
    echo ""
    exit 0
fi

# Parse arguments
ARCHIVE=""
DESTINATION=""
USE_CUSTOM_DEST=0

while [[ $# -gt 0 ]]; do
    case $1 in
        -o|--output)
            DESTINATION="$2"
            USE_CUSTOM_DEST=1
            shift 2
            ;;
        -h|--help)
            $MAL decompress --help
            exit 0
            ;;
        *)
            ARCHIVE="$1"
            shift
            ;;
    esac
done

# Check if archive was provided
if [ -z "$ARCHIVE" ]; then
    echo "Error: No archive file specified!"
    echo "Use './decompress.sh -h' for help."
    exit 1
fi

# Check if archive exists
if [ ! -f "$ARCHIVE" ]; then
    echo "Error: Archive '$ARCHIVE' not found!"
    exit 1
fi

# Run decompression
if [ $USE_CUSTOM_DEST -eq 1 ]; then
    $MAL decompress "$ARCHIVE" -o "$DESTINATION"
else
    $MAL decompress "$ARCHIVE"
fi