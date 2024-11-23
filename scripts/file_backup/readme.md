# File Backup Script

This is a simple bash script to organize and copy files by type (images, videos, audio, or documents) from a source directory to a target directory. The script organizes files into a structured folder hierarchy: `<destination_directory>/<category>/<file_format>/file_name`


## Features
- Supports multiple file types:
  - **Images:** `jpg`, `jpeg`, `png`, `gif`, `bmp`, `tiff`, `webp`
  - **Videos:** `mp4`, `mkv`, `avi`, `mov`, `flv`, `wmv`, `webm`
  - **Audio:** `mp3`, `wav`, `flac`, `aac`, `ogg`, `wma`, `m4a`, `amr`
  - **Documents:** `pdf`, `doc`, `docx`, `xls`, `xlsx`, `ppt`, `pptx`, `txt`, `odt`, `ods`, `odp`

- Generates a summary of files copied for each category.
- Measures the total time taken for the operation.

## Usage

### Prerequisites
- A Linux or Unix-like environment with bash installed.

### Running the Script

1. Place the script in the desired location.
2. Run the script with the following command:
    ```
   ./file_organizer.sh <source_directory> <destination_directory>
   ```
3. Example: `./file_organizer.sh /path/to/source /path/to/destination`

## Notes
- The script skips files that do not match the specified extensions.
- Ensure proper read/write permissions for the source and destination directories.
- Handles filenames with spaces and special characters.