#!/bin/bash

# Function to display the menu
show_menu() {
    echo "Select file types to copy:"
    echo "1) Images"
    echo "2) Videos"
    echo "3) Audio"
    echo "4) Documents"
    echo "5) All of the above"
}

# Function to copy files based on file type and track stats
copy_files() {
    local src="$1"
    local dest="$2"
    local extensions="$3"
    local category="$4"
    local -n count=$5

    for ext in $extensions; do
        # Process files matching the current extension
        while IFS= read -r -d '' file; do
            # Get the file extension (lowercased)
            file_ext=$(echo "${file##*.}" | tr '[:upper:]' '[:lower:]')
            # Create the destination directory if not exists
            dest_dir="$dest/$category/$file_ext"
            mkdir -p "$dest_dir"
            # Copy the file and increment the counter if successful
            if cp -v "$file" "$dest_dir/" &>/dev/null; then
                ((count++))
            fi
        done < <(find "$src" -type f -iname "*.$ext" -print0)
    done
}

# File extensions for each category
image_extensions="jpg jpeg png gif bmp tiff webp"
video_extensions="mp4 mkv avi mov flv wmv webm"
audio_extensions="mp3 wav flac aac ogg wma m4a"
document_extensions="pdf doc docx xls xlsx ppt pptx txt odt ods odp"

# Validate command-line arguments
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <source_directory> <destination_directory>"
    exit 1
fi

source_dir="$1"
dest_dir="$2"

# Validate source directory
if [[ ! -d "$source_dir" ]]; then
    echo "Error: Source directory does not exist!"
    exit 1
fi

# Initialize counters
image_count=0
video_count=0
audio_count=0
document_count=0

# Show menu once
show_menu
read -rp "Enter your choice: " choice

# Record the start time
start_time=$(date +%s)

case $choice in
    1)
        echo "Copying Images..."
        copy_files "$source_dir" "$dest_dir" "$image_extensions" "image" image_count
        ;;
    2)
        echo "Copying Videos..."
        copy_files "$source_dir" "$dest_dir" "$video_extensions" "video" video_count
        ;;
    3)
        echo "Copying Audio..."
        copy_files "$source_dir" "$dest_dir" "$audio_extensions" "audio" audio_count
        ;;
    4)
        echo "Copying Documents..."
        copy_files "$source_dir" "$dest_dir" "$document_extensions" "document" document_count
        ;;
    5)
        echo "Copying All Categories..."
        copy_files "$source_dir" "$dest_dir" "$image_extensions" "image" image_count
        copy_files "$source_dir" "$dest_dir" "$video_extensions" "video" video_count
        copy_files "$source_dir" "$dest_dir" "$audio_extensions" "audio" audio_count
        copy_files "$source_dir" "$dest_dir" "$document_extensions" "document" document_count
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# Record the end time and calculate duration
end_time=$(date +%s)
duration=$((end_time - start_time))

# Display the statistics table
echo
echo "Summary:"
echo "-----------------------------"
printf "%-10s | %s\n" "Category" "Files Copied"
echo "-----------------------------"
printf "%-10s | %d\n" "Images" "$image_count"
printf "%-10s | %d\n" "Videos" "$video_count"
printf "%-10s | %d\n" "Audio" "$audio_count"
printf "%-10s | %d\n" "Documents" "$document_count"
echo "-----------------------------"
echo "Total Time: $duration seconds"
echo "-----------------------------"
