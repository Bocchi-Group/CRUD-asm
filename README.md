# Simple CRUD Membership Database

This is a simple CRUD (Create, Read, Update, Delete) program written in Assembly x86-64, designed for Linux with the System V AMD64 ABI calling convention. The program manages a membership database for a fictional organization. Users can perform various operations, including adding new members, viewing existing members, updating member information, and deleting members from the database.

## Code Structure

The code is organized into different sections: `.rodata`, `.data`, and `.text`. The `.rodata` section contains read-only data, such as strings used for displaying menus, alerts, and user prompts. The `.data` section holds the data structure used to store member records, and the `.text` section contains the main program logic.

## Data Structure

The program utilizes a simple data structure called `struct member` to store member records. The structure consists of the following fields:
- `name[64]`: A character array to store the name of the member (limited to 64 characters).
- `discord_username[32]`: A character array to store the Discord username of the member (limited to 32 characters).
- `gender`: A single character representing the gender of the member, which can be 'm' (male), 'f' (female), or 'h' (hidden).
- `hobby[64]`: A character array to store the hobby of the member (limited to 64 characters).

## Functionality

The program provides a text-based user interface through the terminal. When running the program, users are presented with a menu that includes the following options:
1. **Add a new member**: Allows users to add a new member to the database by providing their name, Discord username, gender, and hobby.
2. **Show members**: Displays the list of existing members in the database, showing their name, Discord username, gender, and hobby.
3. **Update a member**: Allows users to update the information of an existing member. They can modify the member's name, Discord username, gender, or hobby.
4. **Delete a member**: Enables users to remove a member from the database based on their name.
5. **Exit**: Exits the program.

## How to Use

### For Linux:

#### Prerequisites:
1. Ensure that you have GCC and Make installed on your Linux system. If not, you can install them using the following command:
   ```
   sudo apt-get install gcc make -y
   ```

#### Building and Running:
1. Download or clone the repository containing the program's source code.
2. Open a terminal and navigate to the program's directory.
3. Build the program by running the `make` command.
   ```
   make
   ```
4. Execute the program by running the following command:
   ```
   ./bin/main
   ```

### For Windows:

#### Prerequisites:
1. If you don't have GCC and Make installed on your Windows system, you need to install the MinGW-w64 environment, which provides GCC and Make for Windows. You can download the MinGW-w64 installer from [here](https://sourceforge.net/projects/mingw-w64/files/).
   - During installation, make sure to select "x86_64" for the architecture to match the code's x86-64 assembly.
   - Add the installation path (e.g., `C:\mingw-w64\x86_64-8.1.0-posix-seh-rt_v6-rev0\mingw64\bin`) to your system's PATH environment variable.

#### Building and Running:
1. Download or clone the repository containing the program's source code.
2. Open a Command Prompt or PowerShell window and navigate to the program's directory.
3. Build the program by running the following command:
   ```
   mingw32-make
   ```
4. Execute the program by running the following command:
   ```
   bin\main
   ```

## Screenshots


## Note

This program provides a basic framework for managing membership data and can be further expanded to include more features and improvements. It serves as a starting point for a simple CRUD membership database and can be customized as needed for specific use cases. For production use, additional validation and error handling mechanisms should be implemented to ensure data integrity and user experience.
