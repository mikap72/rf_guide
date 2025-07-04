I'll create a bash script that runs Robot Framework tests and sends the output to a subfolder.This bash script provides a complete solution for running Robot Framework tests with organized output management. Here's what it does:

**Key Features:**
- Creates timestamped subfolders for each test run (e.g., `results/run_20240704_143022`)
- Generates all standard Robot Framework output files (log, report, output XML, debug)
- Includes error checking and colored status messages
- Creates a test summary file for each run
- Maintains a symbolic link to the latest test run

**Usage:**
1. Make the script executable: `chmod +x robot_test.sh`
2. Run it: `./robot_test.sh`

**Directory Structure:**
```
project/
├── robot_test.sh
├── tests/           # Your .robot test files go here
└── results/         # Output directory
    ├── run_20240704_143022/
    │   ├── log.html
    │   ├── report.html
    │   ├── output.xml
    │   ├── debug.txt
    │   └── test_summary.txt
    └── latest -> run_20240704_143022/
```

The script automatically creates the necessary directories and provides helpful feedback about what's happening during execution. Each test run gets its own subfolder with a timestamp, making it easy to track and compare results over time.



Perfect! I've updated the script to accept a parameter for specifying which Robot Framework file or directory to run. Here are the key improvements:

**New Features:**
- **Command-line parameter support**: You can now specify a specific test file or directory
- **Help option**: Use `-h` or `--help` to see usage instructions
- **Flexible target validation**: Works with both files and directories
- **Smart defaults**: Falls back to the default "tests" directory if no parameter is provided

**Usage Examples:**
```bash
# Run all tests from default 'tests' directory
./robot_test.sh

# Run a specific test file
./robot_test.sh tests/login.robot
./robot_test.sh my_test.robot

# Run all tests from a specific directory
./robot_test.sh tests/smoke/
./robot_test.sh integration_tests/

# Show help
./robot_test.sh --help
```

**Key Changes:**
1. Added parameter handling to accept test file/directory as first argument
2. Added usage function with help text
3. Enhanced validation to check if the specified target exists
4. Added warning for non-.robot files with confirmation prompt
5. Updated all references to use the dynamic `TEST_TARGET` instead of fixed `TEST_DIR`

The script maintains backward compatibility - if you don't provide any parameters, it will use the default "tests" directory just like before. The output structure and all other features remain the same.