#!/bin/bash
# MAL Compressor - Easy compression script

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
    echo "MAL Compressor - Compression Script"
    echo ""
    echo "Usage: ./compress.sh <files/folders> [options]"
    echo ""
    echo "Examples:"
    echo "  ./compress.sh file.txt                    # Creates file.mal"
    echo "  ./compress.sh folder/                     # Creates folder.mal"
    echo "  ./compress.sh file1.txt file2.txt         # Creates compressedfiles.mal"
    echo "  ./compress.sh file.txt -o custom.mal      # Creates custom.mal"
    echo "  ./compress.sh -l 9 folder/                # Max compression"
    echo ""
    echo "Options:"
    echo "  -l <0-9>  Compression level (default: 6)"
    echo "  -o <file> Output file (auto-generated if not specified)"
    echo "  -h        Show this help"
    echo ""
    exit 0
fi

# Default values
OUTPUT=""
LEVEL="6"
FILES=()

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -l|--level)
            LEVEL="$2"
            shift 2
            ;;
        -o|--output)
            OUTPUT="$2"
            shift 2
            ;;
        -h|--help)
            $MAL compress --help
            exit 0
            ;;
        *)
            FILES+=("$1")
            shift
            ;;
    esac
done

# Check if files were provided
if [ ${#FILES[@]} -eq 0 ]; then
    echo "Error: No files or folders specified!"
    echo "Use './compress.sh -h' for help."
    exit 1
fi

# Run compression with or without output
if [ -z "$OUTPUT" ]; then
    $MAL compress "${FILES[@]}" -l "$LEVEL"
else
    $MAL compress "${FILES[@]}" -o "$OUTPUT" -l "$LEVEL"
fi