#!/bin/bash

# Robot Framework Test Runner Script
# This script runs Robot Framework tests and outputs results to a subfolder
# Usage: ./robot_test.sh [test_file_or_directory]

# Configuration
DEFAULT_TEST_DIR="robot"   # Default directory containing test files
OUTPUT_DIR="results"       # Main output directory
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
RUN_DIR="$OUTPUT_DIR/run_$TIMESTAMP"  # Subfolder for this test run

# Get test target from command line argument or use default
if [ $# -eq 0 ]; then
    TEST_TARGET="$DEFAULT_TEST_DIR"
    print_info="Running all tests from default directory: $DEFAULT_TEST_DIR"
else
    TEST_TARGET="$1"
    if [ -f "$TEST_TARGET" ]; then
        print_info="Running specific test file: $TEST_TARGET"
    elif [ -d "$TEST_TARGET" ]; then
        print_info="Running all tests from directory: $TEST_TARGET"
    else
        print_info="Target specified: $TEST_TARGET"
    fi
fi

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [test_file_or_directory]"
    echo ""
    echo "Arguments:"
    echo "  test_file_or_directory    Path to a specific .robot file or directory containing tests"
    echo "                           If not specified, uses default 'tests' directory"
    echo ""
    echo "Examples:"
    echo "  $0                       # Run all tests from 'tests' directory"
    echo "  $0 tests/login.robot     # Run specific test file"
    echo "  $0 tests/smoke/          # Run all tests from specific directory"
    echo "  $0 my_test.robot         # Run single test file"
}

# Check if Robot Framework is installed
if ! command -v robot &> /dev/null; then
    print_error "Robot Framework is not installed. Please install it with: pip install robotframework"
    exit 1
fi

# Show help if requested
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_usage
    exit 0
fi

# Create output directory structure
print_status "Creating output directory: $RUN_DIR"
mkdir -p "$RUN_DIR"

# Display what we're going to run
print_status "$print_info"

# Validate test target
if [ ! -e "$TEST_TARGET" ]; then
    print_error "Test target '$TEST_TARGET' does not exist"
    if [ "$TEST_TARGET" = "$DEFAULT_TEST_DIR" ]; then
        print_warning "Default test directory '$DEFAULT_TEST_DIR' not found. Creating it..."
        mkdir -p "$DEFAULT_TEST_DIR"
        print_warning "Please add your .robot test files to the '$DEFAULT_TEST_DIR' directory"
    fi
    exit 1
fi

# Check if target is a file and has .robot extension
if [ -f "$TEST_TARGET" ] && [[ "$TEST_TARGET" != *.robot ]]; then
    print_warning "File '$TEST_TARGET' does not have .robot extension"
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Check if there are any robot files in the target
if [ -d "$TEST_TARGET" ]; then
    if [ -z "$(find "$TEST_TARGET" -name "*.robot" -type f)" ]; then
        print_warning "No .robot files found in '$TEST_TARGET' directory"
        exit 1
    fi
fi

# Run Robot Framework tests
print_status "Running Robot Framework tests..."
print_status "Test target: $TEST_TARGET"
print_status "Output directory: $RUN_DIR"

# Robot Framework command with output directory
robot \
    --outputdir "$RUN_DIR" \
    --log log.html \
    --report report.html \
    --output output.xml \
    --debugfile debug.txt \
    --timestampoutputs \
    "$TEST_TARGET"

# Check the exit code
EXIT_CODE=$?

# Create a summary file
SUMMARY_FILE="$RUN_DIR/test_summary.txt"
echo "Robot Framework Test Run Summary" > "$SUMMARY_FILE"
echo "=================================" >> "$SUMMARY_FILE"
echo "Run Date: $(date)" >> "$SUMMARY_FILE"
echo "Test Target: $TEST_TARGET" >> "$SUMMARY_FILE"
echo "Output Directory: $RUN_DIR" >> "$SUMMARY_FILE"
echo "Exit Code: $EXIT_CODE" >> "$SUMMARY_FILE"
echo "" >> "$SUMMARY_FILE"

if [ $EXIT_CODE -eq 0 ]; then
    echo "Result: ALL TESTS PASSED ✓" >> "$SUMMARY_FILE"
    print_status "All tests passed successfully!"
else
    echo "Result: SOME TESTS FAILED ✗" >> "$SUMMARY_FILE"
    print_error "Some tests failed. Check the reports for details."
fi

# Display results location
print_status "Test results saved to: $RUN_DIR"
print_status "Files generated:"
echo "  - log.html (detailed test log)"
echo "  - report.html (test report)"
echo "  - output.xml (test results in XML format)"
echo "  - debug.txt (debug information)"
echo "  - test_summary.txt (run summary)"

# Create a symbolic link to the latest run
LATEST_LINK="$OUTPUT_DIR/latest"
if [ -L "$LATEST_LINK" ]; then
    rm "$LATEST_LINK"
fi
ln -s "$(basename "$RUN_DIR")" "$LATEST_LINK"
print_status "Latest run linked at: $LATEST_LINK"

exit $EXIT_CODE