#!/bin/bash
#********************* 
# Shell Script to migrate the files from Parser NFS Processed directory .snapshot to the OCI Object Storage.
#
# Copy the File from Local to UnixBox
# scp C:\Users\a5143522\CodeBase\PythonJobs\move_job.sh ocradmin@oeforapars001d.adwin.renesas.com:/localdisk/ocradmin/bin
# 
# Convert the file from Windows to Unix Format
# [ocradmin@oeforapars001d bin]$ dos2unix /localdisk/ocradmin/bin/move_job.sh
# dos2unix: converting file /localdisk/ocradmin/bin/move_job.sh to Unix format...
# 
# Execution/Run Shell Script command  - [ocradmin@oeforapars001d bin]$ sh /localdisk/ocradmin/bin/move_job.sh
#
# Execution Shell via nohup to open a new session to run in the background
# [ocradmin@oeforapars001d bin]$ nohup /localdisk/ocradmin/bin/move_job.sh  > outpufile_move_job 2>&1 &
# [1] 1997781
# -rw-r--r--.  1 ocradmin dlgusers   22 Apr 12 14:34 outpufile_move_job
# [1]+  Done                    nohup /localdisk/ocradmin/bin/move_job.sh > outpufile_move_job 2>&1
# [ocradmin@oeforapars001d bin]$ tail -1000 outpufile_move_job
# nohup: ignoring input
#
#**********************

# Source directory
src_dir="/localdisk/ocradmin/bin/test"

# Destination directory
dest_dir="/localdisk/ocradmin/log/test"

echo "#### Started Processing $(date)"  >> /localdisk/ocradmin/log/move_job.log 2>&1

# Count total number of files in source directory
total_files=$(find "$src_dir" -type f | wc -l)
echo "Total number of files in $src_dir: $total_files"  >> /localdisk/ocradmin/log/move_job.log 2>&1

# Iterate through files in source directory
for file in "$src_dir"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        echo "----------- STARTING WORKING WITH $filename --------------" >> /localdisk/ocradmin/log/move_job.log 2>&1
        # Check if file is .zip or .gz
        case "$filename" in
            *.zip|*.gz)
                echo "$(date): Moving $filename into $dest_dir" >> /localdisk/ocradmin/log/move_job.log 2>&1
                mv "$file" "$dest_dir"
                echo "$(date): Moved $filename into $dest_dir" >> /localdisk/ocradmin/log/move_job.log 2>&1
                ;;
            *)
                echo "$(date): Skipping $filename as it is not a .zip or .gz file" >> /localdisk/ocradmin/log/move_job.log 2>&1
                ;;
        esac
        echo "----------- FINISH WORKING WITH $filename --------------" >> /localdisk/ocradmin/log/move_job.log 2>&1
    fi
done

# Count total number of files in destination directory
total_files=$(find "$dest_dir" -type f | wc -l)
echo "Total number of files in $dest_dir: $total_files"  >> /localdisk/ocradmin/log/move_job.log 2>&1

echo "#### Completed Processing $(date)"  >> /localdisk/ocradmin/log/move_job.log 2>&1
