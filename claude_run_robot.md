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